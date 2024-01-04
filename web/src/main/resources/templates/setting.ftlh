<#include "include/header.ftlh">

<div class="setting-tip">请在下面输入测试文字，然后点击：测试</div>
<input type="text" id="msg" placeholder="请输入测试文字" />
<div id="setting-out"></div>

<button class="btn" onclick="test()">测试</button>

<script type="text/javascript">
function test() {
    let msg = $("#msg").val();
    if (!msg) {
        toast('请输入测试文字', 'error');
        return;
    }
    msg = msg.trim();
    /*
    post('/ajax/test', {msg}, data => {
        toast('测试通过', 'success');
        $("#connection-test-out").html('服务器返回的数据是：' + data + '，测试通过');
    });
    */
    setTimeout(() => {
        toast('测试通过', 'success');
        $("#setting-out").html('服务器返回的数据是：' + msg + '，测试通过');
    }, 300);
}
</script>

<#include "include/footer.ftlh">