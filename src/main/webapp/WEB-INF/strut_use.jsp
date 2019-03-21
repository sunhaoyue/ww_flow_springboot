<?xml version="1.0" encoding="UTF-8" ?>
 <%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ taglib uri="/struts-tags" prefix="s" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Struts-Tags学习</title>
</head>
<body>
<ol>
    <li>property: <s:property value="username"/> </li>
    <li>property 取值为字符串: <s:property value="'username'"/> </li>
    <li>property 设定默认值: <s:property value="admin" default="管理员"/> </li>
    <li>property 设定HTML: <s:property value="'<hr/>'" escape="false"/>  这里的escape属性为ture是 会将<s:property value="'<hr/>'" escape="true"/> 当做字符串输出 </li>
    <hr />
    <li>set 设定adminName值（默认为request 和 ActionContext）: <s:set var="adminName" value="username" /></li>

    <li>set 从request取值: <s:property value="#request.adminName" /></li>
    <li>set 从ActionContext取值: <s:property value="#adminName" /></li>

    <%--<li>set 设定范围: <s:set name="adminPassword" value="password" scope="page"/></li>
    <li>set 从相应范围取值: <%=pageContext.getAttribute("adminPassword") %></li>
    --%>
    <li>set 设定var，范围为ActionContext: <s:set var="adminPassword" value="password" scope="session"/></li>
    <li>set 使用#取值: <s:property value="#adminPassword"/> </li>
    <li>set 从相应范围取值: <s:property value="#session.adminPassword"/> </li>

    <hr />

    <li>Value的提供有两种方式，通过value属性或者标签中间的text，不同之处： </li>
    <s:url value="editGadget.action" >
        <s:param name="name">zhaosoft</s:param>
        <li>参数会以String的格式放入statck</li>
        <s:param name="name" value="zhaosoft"/>
        <li>该值会以java.lang.Object的格式放入statck</li>
    </s:url>

    <%--<li>push:<s:set name="myDog" value="new com.bjsxt.struts2.ognl.Dog('oudy')"></s:set></li>
    <li>
        push:<s:push value="#myDog">
        <s:property value="name"/>
    </s:push>
    </li>
    <li>push: <s:property value="name"/></li>
    --%>

    <hr />
    <li>bean 定义bean,并使用param来设定新的属性值:
        <s:bean name="com.smile.struts2.bean.Dog" >
            <s:param name="name" value="'pp'"></s:param>
            <s:property value="name"/>

        </s:bean>

        s:bean执行完了之后就将valuestack中的值出栈


    </li>

    <li>bean 查看debug情况:
        <s:bean name="com.smile.struts2.bean.Dog" var="myDog">
            <s:param name="name" value="'oudy'"></s:param>
        </s:bean>
        拿出值：
        <s:property value="#myDog.name"/>
        <s:debug></s:debug>
    </li>
    <hr />

    <li>include _include1.html 包含静态英文文件
        <s:include value="/_include1.html"></s:include>
    </li>

    <li>include _include2.html 包含静态中文文件
        <s:include value="/_include2.html"></s:include>
    </li>

    <li>include _include1.html 包含静态英文文件，说明%用法
        <s:set var="incPage" value="%{'/_include1.html'}" />
        <s:include value="%{#incPage}"></s:include>
    </li>


    <hr />

    <li>if elseif else:
        age = <s:property value="#parameters.age[0]" /> <br />
        <s:set var="age" value="#parameters.age[0]" />

        <s:if test="#age < 0">wrong age!</s:if>
        <s:elseif test="#parameters.age[0] < 20">too young!</s:elseif>
        <s:else>yeah!</s:else><br />

        <s:if test="#parameters.aaa == null">null</s:if>
    </li>

    <hr />

    <li>遍历集合：<br />
        <s:iterator value="{1, 2, 3}" >
            <s:property/> |
        </s:iterator>
    </li>
    <li>自定义变量：<br />
        <s:iterator value="{'aaa', 'bbb', 'ccc'}" var="x">
            <s:property value="#x.toUpperCase()"/> |
        </s:iterator>
    </li>
    <li>使用status:<br />
        <s:iterator value="{'aaa', 'bbb', 'ccc'}" status="status">
            <s:property/> |
            遍历过的元素总数：<s:property value="#status.count"/> |
            遍历过的元素索引：<s:property value="#status.index"/> |
            当前是偶数？：<s:property value="#status.even"/> |
            当前是奇数？：<s:property value="#status.odd"/> |
            是第一个元素吗？：<s:property value="#status.first"/> |
            是最后一个元素吗？：<s:property value="#status.last"/>
            <br />
        </s:iterator>

    </li>

    <li>
        <s:iterator value="#{1:'a', 2:'b', 3:'c'}" >
            <s:property value="key"/> | <s:property value="value"/> <br />
        </s:iterator>
    </li>

    <li>
        <s:iterator value="#{1:'a', 2:'b', 3:'c'}" var="x">
            <s:property value="#x.key"/> | <s:property value="#x.value"/> <br />
        </s:iterator>
    </li>

    <li>

        <s:fielderror fieldName="fielderror.test" theme="simple"></s:fielderror>

    </li>
    <hr/>

    UI标签
    <s:form>
        <s:select label="最高学历" name="education" list="{'高中','大学','硕士','博士'}"
                  headerKey="-1" headerValue="请选择您的学历"/>
    </s:form>

    <s:form name="test">
        <s:doubleselect label="请选择所在省市"
                        name="province" list="{'四川省','山东省'}" doubleName="city"
                        doubleList="top == '四川省' ? {'成都市', '绵阳市'} : {'济南市', '青岛市'}" />
    </s:form>

    <s:form>
        <s:checkboxlist name="interest" list="{'足球','篮球','排球','游泳'}" label="兴趣爱好"/>
    </s:form>

    <s:form action="login">
        <s:textfield name="user.username" label="用户名"></s:textfield>
        <s:textfield name="user.password" label="密码"></s:textfield>
        <s:submit value="登陆"></s:submit>
        <s:submit value="注册" name="action:register"></s:submit>
        <s:submit value="搜索" name="redirect:www.google.com"></s:submit>
    </s:form>

    <s:form>
        <!-- 使用简单集合来生成可上下移动选项的下拉选择框 -->
        <s:updownselect name="a" label="请选择您喜欢的图书" labelposition="top"
                        moveUpLabel="向上移动"
                        list="{'Spring2.0宝典' , '轻量级J2EE企业应用实战' , 'JavaScript: The Definitive Guide'}"/>
        <!-- 使用简单Map对象来生成可上下移动选项的下拉选择框且使用emptyOption="true"增加一个空选项-->
        <s:updownselect name="b" label="请选择您想选择出版日期" labelposition="top"
                        moveDownLabel="向下移动" list="#{'Spring2.0宝典':'2006年10月' , '轻量级J2EE企业应用实战':'2007月4月' , '基于J2EE的Ajax宝典':'2007年6月'}"
                        listKey="key"
                        emptyOption="true"
                        listValue="value"/>
        <!-- 使用集合里放多个JavaBean实例来可上下移动选项的生成下拉选择框 -->

        <s:bean name="com.smile.struts2.bean.DogService" id="ds" />
        <s:updownselect name="c" label="请选择您喜欢的图书的作者" labelposition="top"
                        selectAllLabel="全部选择" multiple="true"
                        list="#ds.dogs"
                        listKey="author"
                        listValue="name"/>
    </s:form>

    <s:form>
        <s:optiontransferselect
                label="最喜爱的图书"
                name="book1"
                leftTitle="Java图书"
                rightTitle="C/C++图书"
                list="{'《Java Web开发详解》', '《Struts 2深入详解》', '《Java快速入门》'}"
                headerKey="-1"
                headerValue="--- 请选择 ---"
                emptyOption="true"
                doubleName="book2"
                doubleList="{'《VC++深入详解》', '《C++ Primer》', '《C++程序设计语言》'}"
                doubleHeaderKey="-1"
                doubleHeaderValue="--- 请选择 ---"
                doubleEmptyOption="true"
                addToLeftLabel="向左移动"
                addToRightLabel="向右移动"
                addAllToLeftLabel="全部左移"
                addAllToRightLabel="全部右移"
                selectAllLabel="全部选择"
                leftUpLabel="向上移动"
                leftDownLabel="向下移动"
                rightUpLabel="向上移动"
                rightDownLabel="向下移动"/>
    </s:form>
</ol>




</body>
</html>
