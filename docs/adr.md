# ADR（Architectural Decision Records）项目实践方案

## 如何编写 ADR

根据 [https://github.com/phodal/adr](https://github.com/phodal/adr) 中的介绍，安装 adr 工具，使用 adr 工具生成的 adr 模板（ADR template by Michael Nygard，一种最流行的、最简单的模板）进行内容填写。

## ADR 应该记录一些什么

1. 项目的技术栈。理论上，每引入一个第三方库，都应该将其记录在 adr 中，在“讨论”中做出相对详尽的介绍，以便于新进入项目的同事理解这个技术栈的来源。
2. 项目技术实施方案。例如：健康认证服务落地方案。此类方案内容较多，应当将关键时刻的讨论结果记录在 adr 中，方案具体内容可以通过外链的方式记录在 adr 中，保证外链存在性即可。
3. 项目中一些特殊技术点的实现方式。例如一个动画，有两种实现方式，如果进行了对比，发现其中一种有兼容性问题、或者编程范式习惯选择，则应记录在 adr 中方便新进入项目的同事了解上下文。
4. adr 中的决策是可以进行变更的，随时间推移，以前的决策发生较大变化以至于结果变化时，通过创建一个新的 adr 来跟踪新的决策，并且要表明新的 adr 与原有 adr 的关联关系。当决策发生部分变化，不会影响到结果发生变化时，可以在对应 adr 中以时间线的方式添加新的讨论。