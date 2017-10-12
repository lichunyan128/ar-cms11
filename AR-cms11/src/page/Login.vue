<template>
  <div class="hello">	
  	<div class="ar-logo">食·景</div>
  	<div class="ar-role">
			<div><input type="radio" name="loginer" v-model="adminType" value="0"/>&nbsp;管理员</div>
			<div><input type="radio" name="loginer" v-model="adminType" value="1"/>&nbsp;商户</div>
		</div>
  	<div>
	    <div>
	      <div v-if='adminType == "0"'>
          <div class="ar-username">
              	<span>用户名</span><input type="text" id="userName" name="user" v-model='user' placeholder="请输入11位手机号">
          </div>
          <div class="ar-ver">
               <span>验证码</span><input type="text" name="verification" id="verification" placeholder="请输入验证码" v-model="vcn"><input type="button" id="txt_mobile" :value="message" @click="getCode">
          </div>
          <input type="button" id="upload" value="登录" @click="login_admin" class="login_admin">
        </div>
			</div>
			<div>
				<div v-if='adminType == "1"'>
          <div class="ar-username">
                <span>用户名</span><input type="text" id="userName1" v-model='mobile' name="user" placeholder="请输入11位手机号">
          </div>
          <div class="ar-ver">
                <span>密码</span><input type="password" v-model="password" name="password" id="password" placeholder="6-20位字母或数字">
          </div>
          <div @click="forgetPass" class="forget-password">忘记密码</div>
          <div class="clearfix"></div>
          <input type="button" id="upload" value="登录" @click="login_business">
        </div>
			</div>
		</div>
		<div>		
				<div class="ar-tip">登录即表示你同意<div @click="toProtocal" class="ar-protocal">《食景用户协议》</div></div>
		</div>
  </div>
 
</template>

<script scoped>
export default {
  name: 'Login',
  data () {
    return {
      user: '',
      mobile:'18500465533',
      password:'',
      message: '获取验证码',
      t: 120,
      adminType: '1',
      vcn:'',
      access_object:''
    }
  },
  created() {

  },
  methods: {
  	//管理员登陆，获取验证码
  	getCode() {
  		var reg = /^0?1[3|4|5|6|7|8|9][0-9]\d{8}$/;
  		var mobile = localStorage.getItem("mobile");
  		var voucher = localStorage.getItem("voucher");
  		var random_str = localStorage.getItem("random_str");
  		let self = this
			if (reg.test(document.getElementById('userName').value)==false){
			 		alert("请输入正确的手机号");
			 		return false;
			}
			 self.$http.get('http://192.168.3.100/sm/adminLogin.action?mobile='+this.user+mobile+voucher+random_str)
		  .then(function (response) {
		  	//18500465533
			    console.log(response);
			    self.response = response.data;
			    if (response.data == 0) {
			    	alert("手机号不合法");
			    	return;
			    }else {
			    	if (self.message == '获取验证码') {
							let timer = setInterval(function () {
								if (self.t>=1) {
							    self.t--;
							    self.message = '再次发送'+self.t;
							    return;
							 }else if(self.t<1){
							    clearInterval(timer);
							    self.message = '获取验证码';
							    self.t = 120;
							    return;
							  }
							},1000);
					}else{
						return false;
					}
			  }
		  })
		  .catch(function (error) {
		  	alert("程序异常");
		    console.log(error);
		  });
		
		},
		forgetPass () {
			this.$router.push({name: 'retrieve_password',path: '/login/retrieve_password'});
		},
		toProtocal (){
			this.$router.push({name: 'Protocal',path: '/login/protocal'});
		},
		//管理员登录
  	login_admin () {
  		var mobile = localStorage.getItem("mobile");
  		var voucher = localStorage.getItem("voucher");
  		var random_str = localStorage.getItem("random_str");
      let self = this;
      var reg = /^0?1[3|4|5|6|7|8|9][0-9]\d{8}$/;
			 	if (reg.test(document.getElementById('userName').value)==false){
			 		alert("请输入正确的手机号");
			 		return false;
			 	}
			 	if (document.getElementById('verification').value == null||document.getElementById('verification').value == "") {
			 		alert("请输入验证码");
			 		return false;
			 	}
     self.$http.post('/api/abc/adminLoginCheck.action',{mobile:mobile,voucher:voucher,random_str:random_str},'mobile='+this.user+'&admin_vcn='+this.vcn,{'xhrFields' : {withCredentials: true},crossDomain: true})
		  .then(function (response) {
//		    console.log(response);
		    self.response = response.data;
		    
		    if (response.data == 1) {
		    	//添加缓存信息
          self.toHome(self.response);
		    }else {
		    	alert("登录失败");
		    	return;
		    }
			})
		  .catch(function (error) {
		  	alert("登录程序异常");
		    console.log(error);
		  });
    },
    //商户登录
  	login_business() {
  		arpzSetLIEncrypt("18500465533", "123123");
  		var mobile = localStorage.getItem("mobile");
  		var voucher = localStorage.getItem("voucher");
  		var random_str = localStorage.getItem("random_str");
      let self = this;
      var reg = /^0?1[3|4|5|6|7|8|9][0-9]\d{8}$/;
      if (reg.test(document.getElementById('userName1').value)==false){
			 		alert("请输入正确的手机号");
			 		return false;
			 	}
			if (document.getElementById('password').value == null||document.getElementById('password').value == "") {
			 		alert("请输入密码");
			 		return false;
			}
			self.$http({
				method:'post',
				url:"/api/bbb/login/checkArpz.action",
				params:{
					'mobile':mobile,
					'voucher':voucher,
					'random_str':random_str
				}
			})
		  .then(function (response) {
		    self.response = response.data;
		    console.log(response.data);
		    if (response.data.state == -1) {
		    	alert("手机号空");
		    	return;
		    }else if(response.data.state == -2) {
		    	alert("密码空");
		    	return;
		    }else if(response.data.state == -3) {
		    	alert("手机号或密码错误");
		    	return;
		    }else if(response.data.state == 'failed'){
		    	alert("登录失败,请检查用户名和密码是否正确");
		    	return;
		    }else{
		    	self.toHome(self.response);
		    }
		  })
		  .catch(function (error) {
		  	alert("登录程序异常");
		    console.log(error);
		  });	
  	},
  	toHome(data){
  	  let self = this;
  	  //adminType0是管理员，1是商户
		localStorage.clear();
	  localStorage.setItem("userInfo",self.adminType);
	  localStorage.setItem("userMenu",JSON.stringify(data));
	  	self.$router.push({ name: 'nav',path: '/nav'})

  	},
  }
}

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
*{
	margin: 0;
	padding: 0;
}
html{
	background: #fff;
}
input[type=radio] {
	-webkit-appearance: radio;
	width: .42rem;
	height: .42rem;
	border: 1px solid #ccc;
	border-radius: 50%;
	vertical-align: middle;
}

input[type=text],
input[type=password] {
	border: none;
	border: 1px solid transparent;
}

input[name=verification] {
	width:2.8rem;
}
.hello{
	background: #fff;
	padding: 0 .3rem;
	margin-top: 2rem;
}

.ar-logo{
	width: 1.39rem;
	height: 1.39rem;
	border-radius: 50%;
	background: #cd3333;
	color: #fff;
	font-weight: 550;
	text-align: center;
	line-height: 1.39rem;
	margin: 1.23rem auto;
	font-size: .5rem;
}

.ar-role{
	margin: .73rem auto;
	color: #000;
	display: flex;
	flex-flow: row nowrap;
	justify-content: flex-start;
}

.ar-role div:nth-child(2){
	margin-left: 1.58rem;
}

.ar-username{
	padding-bottom: .38rem;
	border-bottom: 1px solid #ccc;
}

.ar-ver{
	padding-top: .65rem;
	padding-bottom: .38rem;
	border-bottom: 1px solid #ccc;
}

.ar-username span,
.ar-ver span{
	display: inline-block;
	width: 1.2rem;
}

.forget-password{
	color: #888;
	float: right;
	margin-top: .42rem;
	margin-bottom: .42rem;
}

.clearfix{
	clear: both;
}

#upload{
	width: 100%;
	border: none;
	font-size: .34rem;
	color: #fff;
	background: #cd3333;
	text-align: center;
	height: .78rem;
	line-height: .78rem;
	margin-bottom: .58rem;
}

#txt_mobile{
font-size: .28rem;
color: #fff;
background: goldenrod;
text-align: center;
padding: 5px 10px;
float: right;
margin-top: -3px;
}

.ar-tip{
	text-align: center;
}
.ar-protocal{
	display: inline;
	color: goldenrod;
}

.login_admin{
	margin-top: .86rem;
}
</style>
