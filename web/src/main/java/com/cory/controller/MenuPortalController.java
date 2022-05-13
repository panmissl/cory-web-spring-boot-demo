package com.cory.controller;

import com.cory.web.controller.BasePortalController;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * 特殊菜单路径：
 *     默认生成后端和前端代码后，前端的访问路径是固定了的，一个model对应一个访问路径。
 *     如果有一些特殊路径需要写到左侧菜单且用来做权限分配（比如订单model后端是同一个，此时生成的访问url是：/xxx/order，但前端要显示成线上订单和线下订单，对应url是：/xxx/order/online和/xxx/order/offline），请在此配置即可。这样就可以在权限管理里给角色分配权限了
 * @author cory
 * @date 2022/02/12
 */
@Controller
public class MenuPortalController extends BasePortalController {

	@GetMapping({"/extpath", "/extpath/subpath"})
	public String index(Model model) {
		return initPortalPageContext(model);
	}
}
