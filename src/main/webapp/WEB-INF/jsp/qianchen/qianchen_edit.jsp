<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="/struts-tags" prefix="s"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>签呈申请单</title>
<jsp:include page="/pages/common.jsp"></jsp:include>
<script type="text/javascript">
			jQuery(document).ready(function(){
		       jQuery("#applyForm").validationEngine();
		    });			
				
		    //表单内容初始化
		    window.onload = function() {
				var editor = CKEDITOR.replace( 'detail',
				{
					skin : 'v2'
				});
				CKEDITOR.instances.detail.setData($("#detaildata").attr("value")); 
				CKEDITOR.on("instanceReady", function(ev){
					editor = ev.editor;
					editor.setReadOnly(true);
				});

				//将部分明细渲染成中文
				renderLevel();
				renderContentType();
				renderDescionMaker();
				renderJoinType();
			
				//会办单位
		    	$("#huibanDept").val($("#jointSignDeptName").attr("value"));
		    	//抄送单位
		    	$("#chaosongDept").val($("#copyDeptName").attr("value"));
		    	//抄送备注
		    	$("#copyDemo").val($("#copyDemohidden").attr("value"));				
				//建议方案
		    	$("#scheme").val($("#schemehidden").attr("value"));
		    	//意见
		    	$("#opinion").val($("#opinionhidden").attr("value"));	    	
		    };
			
			//通过组织查询添加会办单位
			function setHuibanDept(sids,snames){
				configEditHuibanDept(sids,snames);
				if(huibanDeptIds!=oldhuibanDeptIds){
					$("#updateFlag").val('1');
				}
			}
			//通过组织查询添加抄送单位
			function setChaosongDept(sids,snames){
				configEditChaosongDept(sids,snames);			
				if(chaosongDeptIds!=oldchaosongDeptIds){
					$("#updateFlag").val('1');
				}
			}
			//会办指派选择
			function assignWork(personDetail){
				var currentEmployeeId = $("#currentEmployeeId").val();
				if(currentEmployeeId && currentEmployeeId == personDetail.employeeId){
					alert("您选择的指派对象是您自己，请重新选择");
					return false;
				}
				var assignId = personDetail.deptId+","+ personDetail.employeeId+","+personDetail.postCode;		
				$("#assignId").val(assignId);
				document.getElementById('applyForm').action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!assignWork.action";
				document.getElementById('applyForm').submit();
				return true;
			}
			//管理员指派选择
			function adminAssignWork(personDetail){
				var assignId = personDetail.deptId+","+ personDetail.employeeId+","+personDetail.postCode;		
				$("#assignId").val(assignId);
				document.getElementById('applyForm').action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!adminAssignWork.action";
				document.getElementById('applyForm').submit();
			}
			
			//驳回
			function reject(){
				if($("#applyForm").validationEngine('validate')==false){
					return;
				};
				if(editorcheck()==false){
					return;
				};
				document.getElementById('applyForm').action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!rejectWork.action";
				document.getElementById('applyForm').submit();				
			}
			
			//重新起案
			function renew(){
				var workId = document.getElementById('workId').value;
				document.getElementById('applyForm').action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!renewWork.action?type=renew&workId="+workId;
				document.getElementById('applyForm').submit();				
			}

			//驳回中-本人同意（已结案）
			function endFormSubmit(){
				var workId = document.getElementById('workId').value;
				document.getElementById('applyForm').action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!endForm.action?workId="+workId;
				document.getElementById('applyForm').submit();				
			}
			
			//表单提交(同意)
			function applySubmit(){
				var attachmentIds = $("#attachmentIds").attr("value");
				if(attachmentIds){
					$("#updateFlag").val('1');
				}
				
				//检查上级主管
				var postData = {
					"workId":$("#workId").val()
				};
				$.post("<%=request.getContextPath()%>/qianchen/qianChenEditAction!checkMgrPerson.action",postData,function(data){
					if(data.status == "error"){
						alert(data.message);
						return;
					}
					document.getElementById("applyForm").action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!confirmWork.action";				
					document.getElementById('applyForm').submit();
				},"json");
			}
			
			// 呈核上一级
			// 此及与表单提交(同意)是一样，此处重新增加一个方法主要是为
			// 		了区别对待是否是会办的呈核上一级的提交。
			// 		同样是为了减少代码的修改量，所以重新增加一个方法。
			function applySubmit_Ex(){
				var attachmentIds = $("#attachmentIds").attr("value");
				if(attachmentIds){
					$("#updateFlag").val('1');
				}
				
				//var hbChengHe = $("#hbChengHe").val();
				//if (hbChengHe == ""){
				//	$("#hbChengHe").val('0');
				//}
				$("#hbChengHe").val('1');
				
				//检查上级主管
				var postData = {
					"workId":$("#workId").val()
				};
				$.post("<%=request.getContextPath()%>/qianchen/qianChenEditAction!checkMgrPerson.action",postData,function(data){
					if(data.status == "error"){
						alert(data.message);
						return;
					}
					document.getElementById("applyForm").action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!confirmWork.action";				
					document.getElementById('applyForm').submit();
				},"json");
			}
			
			//取消
			function cancel(){
				document.getElementById("applyForm").action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!cancelWork.action";				
				document.getElementById('applyForm').submit();
			}

			//取消
			function cancelForm(){
				document.getElementById("applyForm").action="<%=request.getContextPath()%>/qianchen/qianChenEditAction!cancelForm.action";				
				document.getElementById('applyForm').submit();
			}
			
</script>	
</head>
<body onkeydown="keyDown()" oncontextmenu="event.returnValue=false">
<div class="container">
 <div class="header">
  <div class="titlel01"></div>
  <div class="titlebg01">签呈申请单</div>
  <div class="titler01"></div>
 </div>
 <form id="applyForm" method="post" name="applyForm">
 <input type="hidden" id="currentEmployeeId" value='<s:property value="#session.employeeId"/>'/>
 <input  type="hidden" name="id" id="flowId" value="<s:property value="flow.id"/>"/>
 <input  type="hidden" name="workId" id="workId" value="<s:property value="#request.workId"/>"/>
 <input type="hidden" name="hbChengHe" id="hbChengHe" value="<s:property value='#request.hbChengHe'/>" />
 <input  type="hidden" name="assignDeptId" id="assignDeptId" value="<s:property value="#request.deptId"/>"/>
 <input name="attachmentIds" type="hidden" id="attachmentIds"/>
 <input name="assignId" type="hidden" id="assignId"/> 
 <input  type="hidden" name="updateFlag" id="updateFlag" value="0"/> 
 <input name="flowStatus" type="hidden" id="flowStatus" value="<s:property value="#request.flowStatus"/>"/>
 <input name="workStage" type="hidden" id="workStage" value="<s:property value="#request.workStage"/>"/>
 <input name="showCancelButton" type="hidden" id="showCancelButton" value="<s:property value="#request.showCancelButton"/>"/>
 <input name="role" type="hidden" id="role" value="<s:property value="#request.role"/>"/>
<input name="renewTimes" type="hidden" id="renewTimes" value="<s:property value="#request.renewTimes"/>"/>
<input type="hidden" name="adminAssignDeptId" id="adminAssignDeptId" />
<input type="hidden" name="adminAssignWorkId" id="adminAssignWorkId" />
<input type="hidden" name="adminAssignOldEmployeeId" id="adminAssignOldEmployeeId" />
<input type="hidden" id="flowType" value="1"/>
 <div class="titlebg02">
   <table width="98%" border="0" cellpadding="0" cellspacing="0" class="center">
     <tr>
       <td align="left"><table border="0" cellspacing="0" cellpadding="0">
         <tr>
           <td width="80" height="24" class="text01">申请日期：</td>
           <td><label>
             <input name="applyDate" type="text" class="width01-readOnly" readonly id="applyDate" value="<s:property value="#request.createTime"/>"/>
           </label></td>
         </tr>
       </table></td>
       <td align="right"><table border="0" cellspacing="0" cellpadding="0" width="100%">
         <tr>
           <td width="110" class="text01">表单编号：</td>
           <td><label>
             <input name="formNum" type="text" class="text02-readOnly" readonly id="formNum" value="<s:property value="flow.formNum"/>"/>
           </label></td>
         </tr>
       </table></td>
     </tr>
   </table>
 </div>
 <div class="bgc01">
   <div class="contentstyle">                   
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="24" height="24" align="left" valign="top"><img src="<%=request.getContextPath()%>/images/ico01.gif" width="18" height="18" /></td>
         <td align="left" valign="middle" class="text02">代申请人基本资料</td>
<%--
         <s:if test="#request.workStage=='REJECT'">
         	<td align="right" valign="middle"><input type="button" value="重新起案" onclick="renew()"></td>
         </s:if>
--%>
       </tr>
     </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="80">代申请人姓名：</td>
         <td align="left"><input name="loginRealName" type="text" class="width01-readOnly" readonly id="loginRealName" value="<s:property value="flow.createPerson.name"/>"/></td>
         <td align="right">工号：</td>
         <td align="left"><input name="loginEmployeeId" type="text" class="width01-readOnly" readonly id="loginEmployeeId" value="<s:property value="flow.createPerson.employeeId"/>"/></td>
         <td align="right">职称：</td>
         <td align="left"><input name="loginPostName" type="text" class="width02-readOnly" readonly id="loginPostName" value="<s:property value="flow.createPerson.postName"/>"/></td>
         <td align="right">分机：</td>
         <td align="left"><input name="loginPhone" type="text" class="width03-readOnly" readonly id="loginPhone" value="<s:property value="flow.createPerson.compPhone"/>"/></td>
       </tr>
       <tr>
         <td>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
         <td colspan="7"><label class="width04">
           <input name="textfield7" type="text" class="width0-readOnly" readonly id="textfield7" value="<s:property value="flow.createPerson.deptPath"/>"/>
         </label></td>
        </tr>
     </table>
   </div>
   <div class="contentstyle">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="24" height="24" align="left" valign="top"><img src="<%=request.getContextPath()%>/images/ico01.gif" width="18" height="18" /></td>
         <td align="left" valign="middle" class="text02">申请人基本资料</td>
       </tr>
     </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="80"><div align="justify">申请人姓名：</div></td>
         <td align="left"><input name="actualRealName" type="text" class="width01-readOnly" readonly id="actualRealName" value="<s:property value="flow.actualPerson.name"/>"/></td>
         <td align="right">工号：</td>
         <td align="left"><input name="actualEmployeeId" type="text" class="width01-readOnly" readonly id="actualEmployeeId" value="<s:property value="flow.actualPerson.employeeId"/>"/></td>
         <td align="right">职称：</td>
         <td align="left"><input name="actualPostName" type="text" class="width02-readOnly" readonly id="actualPostName" value="<s:property value="flow.actualPerson.postName"/>"/></td>
         <td align="right">分机：</td>
         <td align="left"><input name="actualPhone" type="text" class="width03-readOnly" readonly id="actualPhone" value="<s:property value="flow.actualPerson.compPhone"/>"/></td>
		 <input name="actualPerson.postCode" type="hidden" id="actualPostCode" value="<s:property value="#request.personDetail.postCode"/>"/>       
       </tr>
       <tr>
         <td>部&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;门：</td>
         <td colspan="7"><label class="width04">
           <input name="actualDept" type="text" class="width0-readOnly" readonly id="actualDept" value="<s:property value="flow.actualPerson.deptPath"/>"/>
         </label></td>
       </tr>
     </table>
   </div>
   <div class="contentstyle">
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="24" height="24" align="left" valign="top"><img src="<%=request.getContextPath()%>/images/ico02.gif" width="18" height="18" /></td>
         <td align="left" valign="middle" class="text02">签呈明细</td>
         <td valign="middle" class="text02">&nbsp;</td>
       </tr>
     </table>
     <table width="100%" border="0" cellspacing="0" cellpadding="0">
       <tr>
         <td width="80" valign="top">发&nbsp;文&nbsp;单&nbsp;位：&nbsp;&nbsp;</td>
         <td colspan="6"><table width="100%" border="0" cellspacing="0" cellpadding="0">
           <tr>
             <td><span class="width04">
               <input name="fawenDept" type="text" class="width0-readOnly" id="fawenDept" readonly value="<s:property value="flow.actualPerson.deptPath"/>" style="width:99%"/>
               <input name="content.deptId" type="hidden" id="fawenDeptId" value="<s:property value="flow.actualPerson.deptId"/>"/>
             </span></td>
           </tr>
         </table></td>
       </tr>
       <tr>
         <td valign="top">机&nbsp;&nbsp;&nbsp;密&nbsp;&nbsp;&nbsp;&nbsp;性：&nbsp;&nbsp;</td>
         <td><label>
           </label>
           <table width="140" border="0" cellpadding="0" cellspacing="0">
             <tr>
               <td><input name="secretLevelName" type="text" id="secretLevelName" class="width01-readOnly" readonly/>
				   <input name="flow.content.secretLevel" type="hidden" id="secretLevel" value="<s:property value="flow.content.secretLevel"/>"/>
               </td>
             </tr>
           </table>
           <label>           </label></td>
         <td width="80">时&nbsp;&nbsp;&nbsp;效&nbsp;&nbsp;&nbsp;&nbsp;性：&nbsp;&nbsp;</td>
         <td><table width="140" border="0" cellpadding="0" cellspacing="0">
           <tr>
             <td><input name="exireLevelName" type="text" id="exireLevelName" class="width01-readOnly" readonly/>
             	 <input name="flow.content.exireLevel" type="hidden" id="exireLevel" value="<s:property value="flow.content.exireLevel"/>"/>
             </td>
           </tr>
         </table></td>
         <td width="80">预&nbsp;估&nbsp;金&nbsp;额：&nbsp;&nbsp;</td>
         <td><label>
           <input name="cash" type="text" id="textfield14" class="width01-readOnly" readonly value="<s:property value="flow.content.cash"/>"/>（元）</label></td>
         <td>&nbsp;</td>
       </tr>
       <tr>
         <td valign="top">类&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;别：&nbsp;&nbsp;</td>
             <td><input name="contentTypeName" type="text" id="contentType" class="width01-readOnly" readonly/>
             	 <input name="flow.content.type" type="hidden" id="type" value="<s:property value="flow.content.type"/>"/>
             </td>
       </tr>
        <!-- 公用明细 -->
	   <jsp:include page="/pages/pub/flow_detail_foredit.jsp">
	   	<jsp:param name="flowType" value="qiancheng"/>
	   </jsp:include>
     </table>
    </div>
  </div>
  </form>
  <div class="bgc01">
  	  <script>
  	  	 var formNum = $("#formNum").attr("value");
  	  </script>
	  <!-- 附件列表 -->
	  <jsp:include page="/pages/pub/flow_attachment.jsp"></jsp:include>
	  <!-- 签核历程 -->
	  <jsp:include page="/pages/pub/flow_history.jsp"></jsp:include>
	  <table width="300" border="0" cellpadding="0" cellspacing="0" class="center">
	  	<tr>
	  		<s:if test="#request.workStage!=null">
		  	    <s:if test="#request.workStage!='COPYDEPT'&&#request.workStage!='REJECT'">
		  	       <s:if test="#request.workStage=='CONFIRM' && !#request.assist">
				   	<td><input type="button" value="本人确认" onclick="applySubmit()"/></td>
				  	<td><input type="button" value="撤销" onclick="cancel()"/></td>	  		
				   </s:if>
				   <s:elseif test="#request.workStage=='JOINTSIGN'||#request.workStage=='INNERJOINTSIGN'||#request.workStage=='CMPCODEJOINTSIGN'||#request.workStage=='SECONDFINAL_DECISION_START'||#request.workStage=='NEXTFINAL_DECISION_START'">
					<s:if test="#request.deptName!=null">
                    <td><font color="red">（<s:property value="#request.deptName"/>）</font></td>
					</s:if>
					<s:if test="#request.curEmployee">
					<td><input type="button" value="提交" onclick="applySubmit()"/></td>
					</s:if>
					<s:if test="#request.hbMgrUser">
					<td><input type="button" value="呈核上一级" onclick="applySubmit_Ex()"/></td>
					</s:if>
				   </s:elseif>
				   <s:elseif test="!#request.assist">
				   	<td><input type="button" value="同意" onclick="applySubmit()"/></td>
				   </s:elseif>
				</s:if>
	       		<s:if test="#request.canRefuse && !#request.assist">
	       		    <td><input type="button" value="驳回" onclick="reject()" /></td>
	       		</s:if>
			</s:if>
			<s:if test="(#request.workStage=='JOINTSIGN'||#request.workStage=='CMPCODEJOINTSIGN'||#request.workStage=='DIVISION_SIGN'||#request.workStage=='BOSS_SIGN')&&#request.role!='ASSIST_NOT_ASSIGNED'">
				<s:if test="#request.workStage=='BOSS_SIGN'">
					<td><input type="button" value="指派" onclick="toBossAssign()" id="bossAssign" /></td>
				</s:if>
				<s:else>
				 <!-- && !#request.isFHeader -->
					<s:if test="#request.workStage=='DIVISION_SIGN'">
					<td><input type="button" value="指派" onclick="toDivisionAssign();" id="divisionAssign" /></td>
					</s:if>
					<s:else>
					<s:if test="#request.hbMgrCanSign && #request.workStage!='DIVISION_SIGN'">
					<td><input type="button" value="指派" onclick="toAssign()" id="assign" /></td>
					</s:if>
					</s:else>
				</s:else>
		    </s:if>
			<s:if test="#request.workStage=='REJECT' && !#request.assist">
					<td><input type="button" value="本人确认" onclick="cancel()"/></td>
					<%--
	         		<td><input type="button" value="撤销" onclick="cancel()"/></td><!-- 暂时不需要 endFormSubmit -->
	         		--%>

			         <s:if test="#request.workStage=='REJECT'">
			         	<td align="right" valign="middle"><input id="renewButton" type="button" value="重新起案" onclick="renew()" /></td>
			         </s:if>

				<!-- 	<td><input type="button" value="取消" onclick="cancel()"/></td>  -->
	        </s:if>

			<s:if test="#request.showCancelButton==1 && !#request.assist">
		    	<td><input type="button" value="撤销" onclick="cancelForm()" id="cancelForm" /></td>   		
		    </s:if>
			<s:if test="#session.employeeId == 'Administrator' || #session.employeeId == 'admin'">
				<td id="adminAssignTd" style="display:none;"><input type="button" value="管理员指派" onclick="toAdminAssign()" id="adminAssign" /></td>
			</s:if>
			<td><input type="button" value="打印" id="printForm" onclick="printForm('<s:property value="flow.formNum"/>', 'qc')" /></td>

	  	</tr>
	  </table>
	</div>
</div>
	<script> 
		loadAttachments();
 		//已选会办单位信息加载
 		var huibanDeptIds = $("#huibanDeptIds").attr("value");
 		var huibanDepts = $("#huibanDept").attr("value");
 		var oldhuibanDeptIds = huibanDeptIds;
 		
 		//已选抄送单位信息加载
 		var chaosongDeptIds = $("#chaosongDeptIds").attr("value");
 		var chaosongDept = $("#chaosongDept").attr("value");
 		var oldchaosongDeptIds = chaosongDeptIds;
 		
 		
 		//用于会办组织过滤
 		var fawenDeptId = $("#fawenDeptId").attr("value");
 		var contentType = $("#type").attr("value");
		var leader = $("#leader").attr("value");
		
		//用于指派过滤
		var assignDeptId = $("#assignDeptId").attr("value");
		
		//如果是查看的话，设置为只读
		var workStage = $("#workStage").attr("value");
		if(!workStage){
			document.getElementById("query3").disabled = "disabled";
			document.getElementById("query4").disabled = "disabled";
			document.getElementById("doUpload").disabled = "disabled";					
		}else{
			//不允许更改会办
			if(workStage=='CMPCODEJOINTSIGN' || workStage == 'JOINTSIGN' || workStage == 'DIVISION_SIGN' || workStage == 'BOSS_SIGN' || workStage == 'FBOSS_SIGN' || workStage == "CONFIRM"){
				document.getElementById("query3").disabled = "disabled";
			}
			
			//最终审核之前都可以附件上传
			if(workStage=='BOSS_SIGN'){
				document.getElementById("doUpload").disabled = "disabled";
				//不允许更改抄送
				document.getElementById("query4").disabled = "disabled";	
			}
		}

		var renewTimes = $("#renewTimes").attr("value");
		if(renewTimes > 0) {
			if (document.getElementById("renewButton"))
			document.getElementById("renewButton").disabled = "disabled";
		}
	</script>
</body>
</html>
