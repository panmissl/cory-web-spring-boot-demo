<#include "include/header.ftlh">

<div class="toast-test-ct">
    <button class="btn" onclick="toast('这是提示消息')">Default</button>
    <button class="btn" onclick="toast('这是提示消息', 'info', 1000)">Info</button>
    <button class="btn" onclick="toast('这是提示消息', 'success', 1000)">Success</button>
    <button class="btn" onclick="toast('这是提示消息', 'warning', 1000)">Warning</button>
    <button class="btn" onclick="toast('这是提示消息', 'error', 1000)">Error</button>
</div>

<script type="text/javascript">
$(function () {
    console.log("page init");
});
</script>

<#include "include/footer.ftlh">