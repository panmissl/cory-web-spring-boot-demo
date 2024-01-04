//console.log('frame js');

function _initHeight() {
    $(window).resize(function(e) {
        //console.log('window resize', $(window).height(), $("#hd").height(), $("#ft").height());

        $("#bd").height($(window).height() - $("#hd").height() - $("#ft").height()-6);
        $(".wrap").height($("#bd").height()-6);
        $(".nav").css("minHeight", $(".sidebar").height() - $(".sidebar-header").height()-1);
        $("#iframe").height($(window).height() - $("#hd").height() - $("#ft").height()-12);
    }).resize();
}

function _setCurrentNav() {
    //console.log('_setCurrentNav');

    const pathname = window.location.pathname;
    const currentNav = $(`.nav a[href="${pathname}"]`);
    //console.log('currentNav', currentNav);
    if (!currentNav) {
        return;
    }
    currentNav.parents('.nav-item').addClass('current');
    $(".global-title h2").html(currentNav.html());

    const subNav = currentNav.parents('.subnav');
    //console.log('subNav', subNav);
    if (subNav) {
        subNav.slideDown();
    }
    currentNav.addClass('color');
}

$(function() {
    _initHeight();
    _setCurrentNav();

    $('.nav>li').click(function () {
        $('.nav>li').removeClass("current");
        $(".subnav li a").removeClass("color");
        $(this).addClass("current");
        var $ul = $(".subnav",this);
        $(".subnav").slideUp();
        if ($ul.is(':visible')) {
            $ul.slideUp();
        }else {
            $ul.slideDown();
        }
    });
    $(".subnav li").click(function(e){
        $(".subnav li a").removeClass("color");
        $("a",$(this)).addClass("color");
        e.stopPropagation();
    });
});

/* common START */
function _processResponse(response, success, loadingId) {
    closeModalLoading(loadingId);
    if (response?.success) {
        success && success(response.object);
    } else {
        toast(`请求数据失败。错误码：${response.errorCode || '无'}，错误消息：${response.errorMsg}`, 'error', 3000);
    }
}

/**
 * 发起一个get请求
 * @param url
 * @param data 参数
 * @param success 成功回调
 */
function get(url, data, success) {
    const loadingId = modalLoading('加载中...');
    $.get(url, data, response => _processResponse(response, success, loadingId), 'json');
}

/**
 * 发起一个post请求
 * @param url
 * @param data 请求数据
 * @param success 成功回调
 */
function post(url, data, success) {
    const loadingId = modalLoading('提交中...');
    $.post(url, data, response => _processResponse(response, success, loadingId), 'json');
}

/**
 * toast显示提示消息，一段时间后消失
 * @param msg
 * @param type info / error / warning / success，默认info
 * @param duration 默认1000，即1秒钟
 */
function toast(msg, type = 'info', duration = 1000) {
    const cls = type === 'error' ? 'red-bg' : type === 'warning' ? 'orange-bg' : type === 'success' ? 'green-bg' : 'blue-bg';
    const dom = $(".global-toast");
    dom.removeClass('red-bg');
    dom.removeClass('blue-bg');
    dom.removeClass('orange-bg');
    dom.removeClass('green-bg');
    dom.html(msg).addClass(cls);
    dom.slideDown();
    setTimeout(() => dom.slideUp(), duration);
}

function _buildEmptyTableTr(colspan) {
    return `<tr class="empty-tr"><td class="empty-td" colspan="${colspan}">无数据</td></tr>`;
}

function _renderColumnData(field, rowData) {
    const data = rowData[field.field];
    if (field.renderer) {
        return field.renderer(data ?? null, rowData);
    } else {
        if (data === null || data === undefined) {
            return '';
        }
        if (field.type === 'float') {
            return new Number(data).toFixed(2);
        } else if (field.type === 'boolean') {
            return data ? '是' : '否';
        } else {
            return data;
        }
    }
}

function _buildTableRow(fields, rowData) {
    const td = fields.map(f => `<td>${_renderColumnData(f, rowData)}</td>`).join('');
    return `<tr>${td}</tr>`;
}

/**
 * 初始化表格，初始化成一个空表格
 * @param tableContainer 表格容器，用jquery取得
 * @param tableId 表的id，后面可以用它获取表
 * @param fields [{title: '字段名，如：姓名', field: '字段属性名，如：name', type: 'string/int/float/boolean'(字段类型，可选，默认是string，比如是float是就要写一下，否则输出精度可能会很长，写了float后会格式化成2位小数，boolean会格式化成是或否，当然也可以通过renderer自定义), renderer: (value, rowValues) => {}}]
 */
function initTable(tableContainer, tableId, fields) {
    const th = fields.map(f => `<th class="table-th">${f.title}</th>`).join('');
    const table = `<table id="${tableId}" class="frame-table"><thead class="table-header"><tr class="table-header-row">${th}</tr></thead><tbody class="table-body">${_buildEmptyTableTr(fields.length)}</tbody></table>`
    tableContainer.append(table);
}

/**
 * 设置table数据
 * @param table 表格，用$.(..)取得
 * @param fields 字段定义
 * @param data 数据：是一个数组
 */
function setTableData(table, fields, data) {
    const body = table.find('.table-body');
    body.empty();
    if (!data || data.length == 0) {
        body.append(_buildEmptyTableTr(fields.length));
    } else {
        data.forEach(row => body.append(_buildTableRow(fields, row)));
    }
}
/* common END */

/*
分页用法：
1、在页面include pagination.ftlh
    <#assign paginationId="main-pagination" />
    <#include "pagination.ftlh">
2、js里调用registerPaginationHandler注册分页信息
3、数据查询成功后，调用setPaginationData设置pagination数据(无论是否能加载到数据都要设置)
*/

const PAGE_SIZE = 20;
const PAGINATION_JUMP_MODE = {
    first: 'first',
    last: 'last',
    prev: 'prev',
    next: 'next',
};
/*
{
    paginationId: {
        paginationJumpHandler: function(targetPageNo) {},
        paginationInfo: {
            pageNo,
            pageSize,
            totalPage,
            totalCount,
        }
    }
}
*/
const PAGINATION_REGISTRY = {};
function _getPaginationRegistry(paginationId) {
    let registry = PAGINATION_REGISTRY[paginationId];
    if (!registry) {
        registry = {};
        PAGINATION_REGISTRY[paginationId] = registry;
    }
    return registry;
}

function registerPaginationHandler(paginationId, paginationJumpHandler) {
    _getPaginationRegistry(paginationId).paginationJumpHandler = paginationJumpHandler;
}

function setPaginationData(paginationId, paginationInfo) {
    _getPaginationRegistry(paginationId).paginationInfo = paginationInfo;

    const paginationCt = $("#" + paginationId);
    paginationCt.find('.current-page').html(paginationInfo?.pageNo || 1);
    paginationCt.find('.total-page').html(paginationInfo?.totalPage || 0);
    paginationCt.find('.total-count').html(paginationInfo?.totalCount || 0);
}

//mode: @see PAGINATION_JUMP_MODE
function _paginationJump(paginationId, mode) {
    const registry = _getPaginationRegistry(paginationId);
    registry.paginationJumpHandler(_calculatePageNo(registry?.paginationInfo, mode));
}

function _calculatePageNo(paginationInfo, mode) {
    if (PAGINATION_JUMP_MODE.first === mode) {
        return 1;
    } else if (PAGINATION_JUMP_MODE.last === mode) {
        return paginationInfo?.totalPage ?? 1;
    } else if (PAGINATION_JUMP_MODE.next === mode) {
        let nextPageNo = paginationInfo?.pageNo + 1;
        if (nextPageNo > paginationInfo?.totalPage) {
            nextPageNo = paginationInfo?.totalPage;
        }
        return nextPageNo;
    } else if (PAGINATION_JUMP_MODE.prev === mode) {
        let prevPageNo = paginationInfo?.pageNo - 1;
        if (prevPageNo <= 0) {
            prevPageNo = 1;
        }
        return prevPageNo;
    } else {
        throw new Error('unsupported jump mode: ' + mode);
    }
}

/**
 * tab的使用：
 * 1、写html。结构：
 * <div class="frame-tab-title-container">
 *     <div class="frame-tab-title" data-content-id="tab-content1">已审批授权</div>
 *     <div class="frame-tab-title" data-content-id="tab-content2">待审批授权</div>
 * </div>
 * <div class="frame-tab-content" id="tab-content1">
 *     这里写内容1
 * </div>
 * <div class="frame-tab-content" id="tab-content2">
 *     这里写内容2
 * </div>
 * 2、调用initTab()方法即可
 */
function initTab() {
    $(".frame-tab-title-container .frame-tab-title").on('click', function() {
        $(".frame-tab-title-container .frame-tab-title").removeClass('active');
        $(this).addClass("active");
        const contentId = $(this).data("content-id");
        $(".frame-tab-content").hide();
        $("#" + contentId).show();
    });
    $(".frame-tab-title-container .frame-tab-title").first().trigger('click');
}

/**
 * 关闭模态框
 * @param loadingId
 */
function closeModalLoading(loadingId) {
    $(`#${loadingId}`).remove();
}

/**
 * 显示一个模态加载框，需要关闭时调用closeModalLoading进行关闭
 * @param loadingMsg
 * @returns {string}
 */
function modalLoading(loadingMsg) {
    const t = new Date().getTime();
    const loadingCtId = 'loading_wrapper_' + t + '_bg';

    $("body").append(`<div id="${loadingCtId}"><div class="frame-modal-bg"></div><div class="frame-modal-loading">${loadingMsg}</div></div>`);
    return loadingCtId;
}

/**
 * 显示一个模态确认框
 * @param title
 * @param content
 * @param okText
 * @param cancelText
 * @param okHandler
 * @param cancelHandler
 */
function modalConfirm(title, content, okText, cancelText, okHandler, cancelHandler) {
    const t = new Date().getTime();
    const bgId = 'confirm_' + t + '_bg';
    const divId = 'confirm_' + t + '_ct';

    function closeModal() {
        $(`#${divId}`).remove();
        $(`#${bgId}`).remove();
    }

    $("body").append(`<div id="${bgId}" class="frame-modal-bg"></div>`);
    $("body").append(`<div id="${divId}" class="frame-modal-ct"><div class="frame-modal-title">${title}<div class="close" title="关闭"></div></div><div class="frame-modal-content">${content}</div><div class="frame-modal-button"><button class="btn ok-btn">${okText}</button><button class="btn cancel-btn">${cancelText}</button></div></div>`);
    $(`#${divId} .ok-btn`).click(() => {
        okHandler && okHandler();
        closeModal();
    });
    $(`#${divId} .cancel-btn`).click(() => {
        cancelHandler && cancelHandler();
        closeModal();
    });
    $(`#${divId} .close`).click(() => closeModal());
}