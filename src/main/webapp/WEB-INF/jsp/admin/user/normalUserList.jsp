<%@ page language="java" pageEncoding="UTF-8"%>
<body>
<script type="text/javascript">
	$(function() {
		normalinit();
	});


	function normalinit(){
		$('#admin_normal_user_datagrid').datagrid({
			url : '${pageContext.request.contextPath}/user/normaluser/all',
			fit : true,
			pagination : true,
			idField : 'id',
			checkOnSelect : false,
			selectOnCheck : false,
			fitColumns : true,
			nowrap : false,
			rownumbers : true,
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : fixWidth(0.06),
				align : 'center',
				//hidden : true,
				checkbox : true
			}, {
				field : 'username',
				title : '用户名',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'nickname',
				title : '昵称',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'realName',
				title : '名字',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'userIdentify',
				title : '生份证',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'phone',
				title : '电话',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'currentArea',
				title : '当前常用地',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'contributeScore',
				title : '贡献值',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'honerScore',
				title : '荣誉值',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'gradeTotal',
				title : '评星总分',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'gradeTimes',
				title : '评星次数',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'withdrawAccount',
				title : '提现账户',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'isLocked',
				title : '状态',
				width : fixWidth(0.06),
				align : 'center',
				formatter : function(value, row, index) {
					if (value == true) {
						return '锁定';
					} else {
						return '活动';
					}
				},
			} ] ],
			toolbar : [{
				text : '添加',
				iconCls : 'icon-remove',
				handler : function() {
					normaluserAddFun();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					normaluserRemove();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					normaluserEditFun();
				}
			},'-', {
				text : '修改密码',
				iconCls : 'icon-edit',
				handler : function() {
					normalpasswordEdit();
				}
			}]
		});
	}



	function normalpasswordEdit() {
		var rows = $('#admin_normal_user_datagrid').datagrid('getChecked');
		if (rows.length == 1) {
			var dp = $('<div/>').dialog({
				width : 270,
				height : 135,
				href : '${pageContext.request.contextPath}/user/normal/password/panel',
				modal : true,
				align : 'center',
				title : '修改密码',
				buttons : [ {
					text : '修改',
					handler : function() {
						var id = $('#id-np').val();
						var newPWD = $('#password-nn').val();
						$.ajax({
							type: 'patch',
							contentType: 'application/json',
							url: '${pageContext.request.contextPath}/user/password',
							processData: false,
							dataType: 'json',
							data : '{"id":\"'+id+'\","password":\"'+newPWD+'\"}',
							success: function(data) {
								if(data){
									$('#admin_normal_user_datagrid').datagrid('load');
									dp.dialog('close');
								}else{
									alert("修改失败!");
								}
							},
							error: function() {
								alert('修改错误!');
							}
						});
					}
				} ],
				onClose : function() {
					$(this).dialog('destroy');
				},
				onLoad : function() {
					$('#admin_normal_password_editForm').form('load', rows[0]);
				}
			});
		} else {
			$.messager.alert('提示', '请勾选一个要编辑的选项！');
		}
	}

	function normaluserEditFun() {
		var rows = $('#admin_normal_user_datagrid').datagrid('getChecked');
		if (rows.length == 1) {
			var d = $('<div/>').dialog({
				width : 270,
				height : 450,
				href : '${pageContext.request.contextPath}/user/normaluser/editpanel',
				modal : true,
				align : 'center',
				title : '修改用户',
				buttons : [ {
					text : '修改',
					handler : function() {
						var id = $('#id-ne').val();
						var username = $('#username-ne').val();
						var realName = $('#realname-ne').val();
						var nickname = $('#nickname-ne').val();
						var userIdentify = $('#userIdentity-ne').val();
						var phone = $('#phone-ne').val();
						var currentArea = $('#currentArea-ne').val();
						var contributeScore = $('#contributeScore-ne').val();
						var honerScore = $('#honerScore-ne').val();
						var gradeTotal = $('#gradeTotal-ne').val();
						var gradeTimes = $('#gradeTimes-ne').val();
						var withdrawAccount = $('#withdrawAccount-ne').val();
						var locked = $('input[type="radio"][name="isLocked"]:checked').val();

						$.ajax({
							type: 'PATCH',
							contentType: 'application/json',
							url: '${pageContext.request.contextPath}/user',
							processData: false,
							dataType: 'json',
							data : '{"id":\"'+id+'\","username":\"'+username+'\","realName":\"'+realName+'\","nickname":\"'+nickname+'\","userIdentify":\"'+userIdentify+'\","phone":\"'+phone+'\","currentArea":\"'+currentArea+'\","contributeScore":\"'+contributeScore+'\","honerScore":\"'+honerScore+'\","gradeTotal":\"'+gradeTotal+'\","gradeTimes":\"'+gradeTimes+'\","withdrawAccount":\"'+withdrawAccount+'\","isLocked":\"'+locked+'\"}',
							success: function(data) {
								if(data){

									$('#admin_normal_user_datagrid').datagrid('unselectAll');
									$('#admin_normal_user_datagrid').datagrid('load');
									d.dialog('destroy');
								}else{
									alert("修改失败!");
								}
							},
							error: function() {
								alert('修改错误!');
							}
						});
					}
				} ],
				onClose : function() {
					$(this).dialog('destroy');
				},
				onLoad : function() {

					$('#admin_normal_user_editForm').form('load', rows[0]);

				}
			});
		} else {
			$.messager.alert('提示', '请勾选一个要编辑的选项！');
		}
	}

	function normaluserAddFun() {

		$.ajax({
			type: 'get',
			contentType: 'application/json',
			url: '${pageContext.request.contextPath}/role/all/list',
			processData: false,
			dataType: 'json',
			async:false,
			success: function(data) {
				$("#role-select-a").empty();
				$.each(data, function (index, value) {
					$("#role-select-a").append("<option value='"+value.id+"'>"+value.description+"</option>");
				});
			},
			error: function() {
				alert('Err...');
			}
		});



		$('#admin_normal_user_addForm input').val('');
		$('#admin_normal_user_addForm select').val('');
		$('#admin_normal_user_addDialog').dialog('open');


		$('#role-select-a').combobox({
			onChange: function() {
				var value = $('#role-select-a').combobox('getValues');
				console.log(value);
				console.log(value.join(','));

			}
		});

	}

	function normaluserRemove() {
		var rows = $('#admin_normal_user_datagrid').datagrid('getChecked');
		//	var rows=$('#admin_normal_user_datagrid').datagrid('getSelected');
		//	var rows=$('#admin_normal_user_datagrid').datagrid('getSelecteds');
		var ids = [];
		if (rows.length > 0) {
			$.messager.confirm('确认', '您是否要删除当前选中的选项？', function(r) {
				if (r) {
					for ( var i = 0; i < rows.length; i++) {
						ids.push(rows[i].id);
						ids.join(',')
					}
					$.ajax({
						type: 'delete',
						url : '${pageContext.request.contextPath}/user/'+ids,
						data : {
							ids : ids.join(',')
						},
						dataType : 'json',
						success : function(d) {
							var v = $('#admin_normal_user_datagrid');
							v.datagrid('reload');
							v.datagrid('unselectAll');
							v.datagrid('clearChecked');
							$.messager.show({
								title : '提示',
								msg : '删除成功'
							});
						}
					});

				}
			});

		} else {
			$.messager.show({
				title : '提示',
				msg : '请勾选要删除的选项！'
			});
		}

	}

	function normalproClearFun() {
		$('#admin_normal_user_datagrid input[name=name]').val('');
		$('#admin_normal_user_datagrid').datagrid('load', {});
	}

	function nregisterUser() {
		var nusername = $('#username-na').val();
		var npassword = $('#password-na').val();
		var nrealName = $('#realname-na').val();
		var nnickname = $('#nickname-na').val();
		var nuserIdentify = $('#userIdentity-na').val();
		var nphone = $('#phone-na').val();
		var ncurrentArea = $('#currentArea-na').val();
		var ncontributeScore = $('#contributeScore-na').val();
		var nhonerScore = $('#honerScore-na').val();
		var ngradeTotal = $('#gradeTotal-na').val();
		var ngradeTimes = $('#gradeTimes-na').val();
		var nwithdrawAccount = $('#withdrawAccount-na').val();
		var nisLocked = $('#locked-na').val();

		$.ajax({
			type: 'POST',
			contentType: 'application/json',
			url: '${pageContext.request.contextPath}/user',
			processData: false,
			dataType: 'json',
			data :  '{"username":\"'+nusername+'\","password":\"'+npassword+'\","realName":\"'+nrealName+'\","nickname":\"'+nnickname+'\","userIdentify":\"'+nuserIdentify+'\","phone":\"'+nphone+'\","currentArea":\"'+ncurrentArea+'\","contributeScore":\"'+ncontributeScore+'\","honerScore":\"'+nhonerScore+'\","gradeTotal":\"'+ngradeTotal+'\","gradeTimes":\"'+ngradeTimes+'\","withdrawAccount":\"'+nwithdrawAccount+'\","isLocked":\"'+nisLocked+'\"}',
			success: function(data) {
				if(data){
					$('#admin_normal_user_datagrid').datagrid('load');
					$('#admin_normal_user_addDialog').dialog('close');
				}else{
					alert("用户已经存在");
				}
			},
			error: function() {
				alert('注册失败');
			}
		});
	}

	function nUserSearchFun() {

		$('#admin_normal_user_datagrid').datagrid({
			url : '${pageContext.request.contextPath}/user/key',
			fit : true,
			pagination : true,
			idField : 'id',
			checkOnSelect : false,
			selectOnCheck : false,
			fitColumns : true,
			nowrap : false,
			rownumbers : true,
			queryParams: {
				key : $("input[name$='key']").val()
			},
			frozenColumns : [ [ {
				field : 'id',
				title : '编号',
				width : fixWidth(0.06),
				align : 'center',
				//hidden : true,
				checkbox : true
			}, {
				field : 'username',
				title : '用户名',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'nickname',
				title : '昵称',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'realName',
				title : '名字',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'userIdentify',
				title : '生份证',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'phone',
				title : '电话',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'currentArea',
				title : '当前常用地',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'contributeScore',
				title : '贡献值',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'honerScore',
				title : '荣誉值',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'gradeTotal',
				title : '评星总分',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'gradeTimes',
				title : '评星次数',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'withdrawAccount',
				title : '提现账户',
				width : fixWidth(0.06),
				align : 'center',
			},{
				field : 'isLocked',
				title : '状态',
				width : fixWidth(0.06),
				align : 'center',
				formatter : function(value, row, index) {
					if (value == true) {
						return '锁定';
					} else {
						return '活动';
					}
				},
			} ] ],
			toolbar : [{
				text : '添加',
				iconCls : 'icon-remove',
				handler : function() {
					normaluserAddFun();
				}
			}, '-', {
				text : '删除',
				iconCls : 'icon-remove',
				handler : function() {
					normaluserRemove();
				}
			}, '-', {
				text : '修改',
				iconCls : 'icon-edit',
				handler : function() {
					normaluserEditFun();
				}
			},'-', {
				text : '修改密码',
				iconCls : 'icon-edit',
				handler : function() {
					normalpasswordEdit();
				}
			}]
		});


		//$('#admin_zjgl_zjgl_datagrid').datagrid('load', serializeObject($('#admin_zjgl_zjgl_searchForm')));
	}

	function nUserSearchFun1() {
		$('#admin_book_layout input[name=key]').val('');
		normalinit();
	}
</script>

<div id="admin_book_layout" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'north',title:'查询条件',border:false" style="height: 70px;">
		<form id="admin_product_searchForm">
			检索用户(可模糊查询):<input name="key" /> </a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'" onclick="nUserSearchFun()">查询</a> <a href="#" class="easyui-linkbutton" data-options="iconCls:'icon-back'" onclick="nUserSearchFun1()">清空</a>
		</form>
	</div>
	<div data-options="region:'center',border:false">
		<table id="admin_normal_user_datagrid" data-options="border:false"></table>
	</div>

</div>

<div id="admin_normal_user_addDialog" class="easyui-dialog"
	 data-options="closed:true,modal:true,title:'添加用户',buttons:[{
					text : '添加',
					iconCls : 'icon-add',
					handler : function() {
                        nregisterUser();
					}}]"
	 style="width: 280px; height: 445px;" title="添加用户">
	<form id="admin_normal_user_addForm" method="post">
		<table>
			<tr>
				<th>用户名</th>
				<td><input id="username-na" name="username" class="easyui-validatebox" data-options="required:true" style="width: 100%" /></td>
			</tr>
			<tr>
				<th>密码</th>
				<td><input type="password" id="password-na" name="password" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>昵称</th>
				<td><input id="nickname-na" name="nickname" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>名字</th>
				<td><input id="realname-na" name="realName" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>身份证</th>
				<td><input id="userIdentity-na" name="userIdentify" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>电话</th>
				<td><input id="phone-na" name="phone" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>当前常用地</th>
				<td><input id="currentArea-na" name="currentArea" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>贡献值</th>
				<td><input id="contributeScore-na" name="contributeScore" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>荣誉值</th>
				<td><input id="honerScore-na" name="honerScore" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>评星总分</th>
				<td><input id="gradeTotal-na" name="gradeTotal" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>评星次数</th>
				<td><input id="gradeTimes-na" name="gradeTimes" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>提现账户</th>
				<td><input id="withdrawAccount-na" name="withdrawAccount" class="easyui-validatebox" style="width: 100%"/></td>
			</tr>
			<tr>
				<th>是否锁定</th>
				<td>
					<select  id="locked-na"  class="esayui-combobox"  name="isLocked"   style="width: 100%" data-options="required:true">
						<option id="true" value='true'>锁定</option>
						<option id="false" value='false' selected = "selected" >活动</option>
					</select>
				</td>
			</tr>

			<tr align="center">

			</tr>

		</table>
	</form>
</div>

<div id="mydialog-e"></div>
<div id="mydialog-p"></div>
</body>
</html>