package com.zyfz.web.controller;

import com.zyfz.domain.Category;
import com.zyfz.service.*;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;

/**
 * Created by ron on 16-10-25.
 */
@RequestMapping("/category")
@Controller
public class CategoryController {
    @Resource
    ICategoryService categoryService;

    @Resource
    IHelpInfoService helpInfoService;

    @Resource
    ITaskInfoService taskInfoService;

    @Resource
    IServerInfoService serverInfoService;

    @RequiresPermissions("category:view")
    @RequestMapping(value = "/list-panel",method = RequestMethod.GET)
    public String list(Model model){
        model.addAttribute("categoryList",categoryService.getAllWithList());
        return "admin/category/list";
    }

    @RequiresPermissions("category:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.GET)
    public String showAppendChildForm(@PathVariable("parentId") Integer parentId, Model model) {
        Category mcategory = new Category();
        mcategory.setId(parentId);
        Category parent = categoryService.getOneById(mcategory);
        model.addAttribute("parent", parent);
        Category child = new Category();
        child.setParentId(parentId);
        child.setParentIds(parent.makeSelfAsParentIds());
        model.addAttribute("category", child);
        model.addAttribute("op", "新增子节点");
        return "admin/category/edit";
    }


    @RequiresPermissions("category:create")
    @RequestMapping(value = "/{parentId}/appendChild", method = RequestMethod.POST)
    @ResponseBody
    public Object create(@RequestBody Category category) {
        categoryService.save(category);
        return true;
    }


    @RequiresPermissions("category:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
    public String showUpdateForm(@PathVariable("id") Integer id, Model model) {
        Category category = new Category();
        category.setId(id);
        Category child = categoryService.getOneById(category);
        model.addAttribute("category",child );
        model.addAttribute("op", "修改");
        Category category1 = new Category();
        category1.setId(child.getParentId());
        Category parent = categoryService.getOneById(category1);
        model.addAttribute("parent",parent);
        return "admin/category/edit";
    }


    @RequiresPermissions("category:update")
    @RequestMapping(value = "/{id}/update", method = RequestMethod.POST)
    @ResponseBody
    public Object update(@RequestBody  Category category) {
        categoryService.update(category);
        return true;
    }

    @RequiresPermissions("category:delete")
    @RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
    @ResponseBody
    public Object delete(@PathVariable("id") Integer id) {
        Category category = new Category();
        category.setId(id);
        Boolean check1 = helpInfoService.selectByCategory(id) == null;
        Boolean check2 = serverInfoService.selectByCategory(id) == null;
        Boolean check3 = helpInfoService.selectByCategory(id) == null;

        if (check1 && check2 && check3){
            categoryService.deleteOneById(category);
        }

        return true;
    }
}
