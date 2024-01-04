<#include "include/header.ftlh">

<div class="frame-tab-title-container">
    <div class="frame-tab-title" data-content-id="approved-tab-content">已审批授权</div>
    <div class="frame-tab-title" data-content-id="to-approve-tab-content">待审批授权</div>
</div>
<div class="frame-tab-content" id="approved-tab-content">
    <div>
        <button class="btn query-btn" onclick="queryApprovedCredit()">查询</button>
    </div>

    <div id="approved-credit-container" class="credit-container"></div>
    <div class="approved-table-container"></div>
</div>

<div class="frame-tab-content" id="to-approve-tab-content">
    <div>
        <button class="btn query-btn" onclick="queryToApproveCredit()">查询</button>
    </div>

    <div id="to-approve-credit-container" class="credit-container"></div>
    <div class="to-approve-table-container"></div>
</div>

<script type="text/javascript">
    const STATUS = {
        TO_APPROVE: '待审批',
        APPROVED: '审批通过',
        REJECT: '驳回',
    };

    const approvedTableFields = [{
        title: '供应商代码',
        field: 'creditCode',
    }, {
        title: "供应商名称",
        field: 'creditName',
    }, {
        title: '授权编号',
        field: 'creditNo',
    }, {
        title: '供应商代码(医院方)',
        field: 'supplierCode',
        renderer: (v, r) => v ? v : '<button class="btn" onclick="updateSupplierCode(\'' + r.creditCode + '\')">设置</button>',
    }];

    const toApproveTableFields = [{
        title: '授权编号',
        field: 'creditNo',
    }, {
        title: '供应商代码',
        field: 'creditCode',
    }, {
        title: "供应商名称",
        field: 'creditName',
    }, {
        title: '银行代码',
        field: 'bankCode',
    }, {
        title: '银行名称',
        field: 'bankName',
    }, {
        title: '状态',
        field: 'status',
        renderer: v => STATUS[v] || v,
    }, {
        title: '操作',
        field: 'id',
        renderer: v => '<button class="btn" onclick="approve(' + v + ')">授权审批</button>',
    }];

    function queryParam() {
        return {pageNo: 1, pageSize: PAGE_SIZE};
    }

    function queryApprovedCredit() {
        doQueryCredit(true);
    }

    function queryToApproveCredit() {
        doQueryCredit(false);
    }

    function approve(id) {
        modalConfirm('授权审批', '请选择审批结果', '通过', '驳回', () => {
            if (confirm('确认通过？')) {
                doApprove(id, true);
            }
        }, () => {
            if (confirm('确认驳回？')) {
                doApprove(id, false);
            }
        });
    }

    function updateSupplierCode(creditCode) {
        const input = '<input type="text" id="supplier-code" placeholder="请输入供应商编码" />';
        modalConfirm('设置供应商编码', input, '确定', '取消', () => {
            let supplierCode = $("#supplier-code").val();
            if (!supplierCode || supplierCode === "") {
                toast('请输入供应商编码', 'error');
                return;
            }
            supplierCode = supplierCode.trim();
            if (supplierCode === "") {
                toast('请输入供应商编码', 'error');
                return;
            }
            /*
            post('/ajax/update_supplier_code', {creditCode, supplierCode}, () => {
                toast('设置成功', 'success');
                window.location.reload();
            });
            */
            setTimeout(() => {
                toast('设置成功', 'success');
                window.location.reload();
            }, 300);
        });
    }

    function doApprove(id, isPass) {
        /*
        post('/ajax/authorization/approve', {id, isPass}, () => {
            toast('审批完成', 'success');
            window.location.reload();
        });
        */
        setTimeout(() => {
            toast('审批完成', 'success');
            window.location.reload();
        }, 300);
    }

    function doQueryCredit(isApproved) {
        const url = '/ajax/query/authorization/info';
        const table = isApproved ? $('#approved-table') : $('#to-approve-table');
        const fields = isApproved ? approvedTableFields : toApproveTableFields;
        const creditContainer = isApproved ? $("#approved-credit-container") : $("#to-approve-credit-container");

        //get(url, queryParam(isApproved), data => setCreditData(table, fields, creditContainer, data));
        const data = isApproved ? [{
            creditCode: 'cmb',
            creditName: '招商银行',
            creditNo: '123',
            supplierCode: 'cmb-supplier',
        }, {
            creditCode: 'icbc',
            creditName: '工商银行',
            creditNo: '456',
        }] : [{
            id: 1,
            creditNo: '123',
            creditCode: 'cmb',
            creditName: '招商银行',
            bankCode: 'cmb',
            bankName: '招商银行',
            status: 'TO_APPROVE',
        }, {
            id: 2,
            creditNo: '456',
            creditCode: 'icbc',
            creditName: '工商银行',
            bankCode: 'icbc',
            bankName: '工商银行',
            status: 'TO_APPROVE',
        }];
        setTimeout(() => setCreditData(table, fields, creditContainer, data), 300);
    }

    function setCreditData(table, tableFields, creditContainer, data) {
        //先设置表格数据，没有会渲染成：无数据
        setTableData(table, tableFields, data);

        if (!data || data.length === 0) {
            toast('没有查到授权数据', 'warning')
            return;
        }
        toast('查询成功', 'success');
    }

    $(function () {
        initTab();
        initTable($('.approved-table-container'), 'approved-table', approvedTableFields);
        initTable($('.to-approve-table-container'), 'to-approve-table', toApproveTableFields);
        queryApprovedCredit();
    });
</script>

<#include "include/footer.ftlh">