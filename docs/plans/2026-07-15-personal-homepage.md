# 个人主页实施计划

> **给 Claude：** 必须使用 `superpowers:executing-plans` 子技能，按任务逐项执行本计划。

**目标：** 创建以本地壁纸为首屏背景、包含个人介绍、项目展示与友情链接的 GitHub Pages 单页模板。

**架构方案：** 在 `index.html` 中使用语义化区块组织首屏、项目、友链和页脚，并以内嵌 CSS 实现响应式布局。项目内容直接写在 HTML 中，便于无需构建步骤的后续维护。仅添加一个原生 JavaScript 处理当前年份。

**技术栈：** HTML5、CSS3、原生 JavaScript、GitHub Pages。

---

## 任务拆解

### 任务 1：定义静态页面验收检查

**涉及文件：**
- 新建：`tests/check-homepage.ps1`
- 测试：`tests/check-homepage.ps1`

**步骤 1：先写一个失败的测试**

编写 PowerShell 检查，断言 `index.html` 包含 `wallpaper.jpg`、`#projects`、`#friends` 与至少一个项目图片元素。

**步骤 2：运行测试，确认它先失败**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：**失败（FAIL）**，因为当前首页只有一个 `Hello` 段落。

### 任务 2：实现单页个人主页

**涉及文件：**
- 修改：`index.html`

**步骤 1：编写最小实现，让测试通过**

替换现有页面，加入：

```html
<header class="hero">...</header>
<main>
  <section id="projects">...</section>
  <section id="friends">...</section>
</main>
<footer>...</footer>
```

样式应将 `wallpaper.jpg` 作为首屏背景，提供暗色遮罩、响应式项目网格、无障碍焦点状态和小屏单列布局。项目卡保留可替换的图片、描述、标签和链接。

**步骤 2：再次运行测试，确认它通过**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：**通过（PASS）**。

### 任务 3：验证交付质量

**涉及文件：**
- 修改：`index.html`
- 测试：`tests/check-homepage.ps1`

**步骤 1：检查静态页面结构**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：所有首页结构断言通过。

**步骤 2：检查版本控制差异**

运行：`git diff --check` 与 `git status --short`

预期：无空白错误；仅显示本次首页与文档相关改动。

## 风险与注意事项

- 正式内容发布前，将示例姓名、项目地址、友链地址与图片地址替换为真实内容。
- `wallpaper.jpg` 必须与 `index.html` 一同提交，GitHub Pages 才能加载背景图。
