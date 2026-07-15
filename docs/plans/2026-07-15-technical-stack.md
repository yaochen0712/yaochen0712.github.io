# 技术栈展示实施计划

> **给 Claude：** 必须使用 `superpowers:executing-plans` 子技能，按任务逐项执行本计划。

**目标：** 在个人主页的 `#stacks` 区域增加四组工程能力卡片，展示 FPGA、嵌入式、数字验证与 PCB 设计技术栈。

**架构方案：** 在 `index.html` 的现有 `#stacks` 预留区域中添加语义化能力卡片网格，并使用新增的局部 CSS 类保持与项目卡一致的视觉语言。更新现有静态 PowerShell 检查，确保关键区域和工具名称不会被后续修改遗漏。

**技术栈：** HTML5、CSS3、PowerShell 静态检查。

---

## 任务拆解

### 任务 1：扩展技术栈静态验收

**涉及文件：**
- 修改：`tests/check-homepage.ps1`
- 测试：`tests/check-homepage.ps1`

**步骤 1：先写一个失败的测试**

在需求表中加入以下页面文本：`id="stacks"`、`异构计算与 FPGA`、`嵌入式固件开发`、`数字 IC 设计与验证`、`原理图与 PCB 设计`、`Vitis`、`Verdi`、`嘉立创 EDA`。

**步骤 2：运行测试，确认它先失败**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：**失败（FAIL）**，因为当前空技术栈区不包含上述卡片内容。

### 任务 2：实现能力方向卡片

**涉及文件：**
- 修改：`index.html`

**步骤 1：编写最小实现，让测试通过**

在 `#stacks` 内加入标题和四个 `article.stack-card`：

```html
<div class="stack-grid">
  <article class="stack-card">
    <h3>异构计算与 FPGA</h3>
    <p>...</p>
    <ul class="tags">...</ul>
  </article>
</div>
```

新增 `stack-grid` 与 `stack-card` 样式，默认两列、800px 以下单列，且复用现有颜色变量与圆角约束。

**步骤 2：再次运行测试，确认它通过**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：**通过（PASS）**。

### 任务 3：验证交付质量

**涉及文件：**
- 修改：`index.html`
- 修改：`tests/check-homepage.ps1`

**步骤 1：检查静态页面结构**

运行：`powershell -ExecutionPolicy Bypass -File tests/check-homepage.ps1`

预期：所有原有首页与新增技术栈断言通过。

**步骤 2：检查版本控制差异**

运行：`git diff --check` 与 `git diff -- index.html tests/check-homepage.ps1`

预期：无空白错误；改动仅限技术栈区与验收脚本。

## 风险与注意事项

- 不要加入未经用户确认的熟练度数值、软件版本或商业 Logo。
- 保持卡片描述简洁，避免技术栈区比项目展示更抢眼。
