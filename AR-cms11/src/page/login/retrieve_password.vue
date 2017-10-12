<template>
	<div class="retrieve-box">
		<div class="register-mobile">
			注册手机号：<input type="tel" placeholder="请输入11位手机号" id="mobile" v-model="mobile" maxlength="11"/>
		</div>
		<div class="message-code">
			短信验证码：<input type="text" name="verification" placeholder="请输入验证码" id="verification" v-model="vcn"><input type="button" @click="getCode()" value="获取验证码" class="get-code" />
		</div>
		<div>
			<input type="button" id="submit" @click="submit()" value="提交" />
		</div>
	</div>
</template>

<script>
	import axios from 'axios'
	export default {
		name: 'retrieve_password',
		data() {
			return {
				mobile: '',
				vcn: ''
			}
		},
		methods: {
			getCode() {
				return axios.post('http://192.168.3.100','mobile='+this.mobile+'&admin_vcn='+this.vcn)
				.then(function (response) {
				    console.log(response);
				    self.response = response.data;
				    if (response.data == 'success') {
				    			    //添加缓存信息
				    
				    }else {
				    	alert("登录失败");
				    }
				})
				.catch(function (error) {
				  	alert("登录程序异常");
				    console.log(error);
				});
			},
			submit() {
				this.$router.push({path:'/login/confirm'});
			}
		}
		
	}
</script>

<style>
*{padding: 0;margin: 0;}
input{
	border: none;
}

.register-mobile {
	margin-top:1.1rem;
	padding-bottom: .47rem;
	border-bottom: 1px solid #e1e1e1;
}
.message-code{
	padding: .47rem 0;
	border-bottom: 1px solid #e1e1e1;
	margin-bottom: .7rem;
}
.message-code input[type=text]{
	width: 2.8rem;
	}
.retrieve-box{
	padding: 0 .2rem 0 .25rem;
	margin-top: 1.5rem;
}
.get-code{
	height: 0.57rem;
	width:1.83rem;
	font-size: .25rem;
	color: #fff;
	background: #DAA520;
	text-align: center;
	float:right;
}
#submit{
	height: .78rem;
	line-height: .78rem;
	color: #fff;
	background: #CD3333;
	text-align: center;
	width: 100%;
	font-size: .34rem;
}
</style>