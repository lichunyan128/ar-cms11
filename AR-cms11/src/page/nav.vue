<template>
	<div class="Nav">
		<div class="navTop">
			<div class="navTopText clearfix">
				<input type="text" class="verifiyCode"  v-model="value" placeholder="请输入就餐码进行验证"
					onfocus="this.placeholder=''" 
					onblur="this.placeholder='请输入就餐码进行验证'"
					@focus="eatingYards" @keyup="VerifyCode"
					maxlength="5"
					/>
				<div class="CodeBtn" :style="{background:CodeBtnColor}" @click="VerifyBtn">验证</div>
			</div>
			<div class="shop">
				<p>当前店铺：&nbsp;<span>果脯1</span></p>
				<p>状态：&nbsp;<span>运营中</span></p>
			</div>
		</div>
		<hr class="interval"/>
		<ul class="NavList"><br />
			<li v-for="(list,index) in backstageMenu">
				<router-link :to="{name:list.item_name,params:{userInfo:userType,userMenu:userMenu}}">
					{{list.notes}}
					<i v-if="index==8" class="listSelectStore">店铺</i>
				</router-link>
				<em class="LightGrayFont">></em>
			</li>
		</ul>
		<div class="popUp-cover" v-if="isShowPop">
		 	<transition name="drop">
			 	<div class="popUp-content">
			 		<div v-if="value==''" class="popUp-text">请输入验证码！</div>
			 		<div v-else-if="value.length<5" class="popUp-text">验证码错误！</div>
			 		<div v-else class="popUp-text">验证成功！</div>
			 		<input type="button" value="好" @click="closeMyself"></input>
			 	</div>
			</transition>
		</div>
		
	</div>
</template>

<script>
	export default{
		name : 'Nav',
		data() {
			return {
				userType:"",
			 	userMenu:"",
	  			backstageMenu:[],
	  			CodeBtnColor:'#a8a8a8',
	  			isShowPop:false,
	  			value:'',
			}
		},
		created() {
			this.userType= localStorage.getItem("userInfo"),		
			this.userMenu= JSON.parse(localStorage.getItem("userMenu"))
			this.backstageMenu = this.userMenu.backstage_menu
		},
		methods: {
			eatingYards(){
				this.CodeBtnColor="#e43730"
			},
			VerifyCode(){
				this.CodeBtnColor="#e43730"
				let reg=/^\d+$/;
				if(!reg.test(this.value)){
					this.value=''
				} 
			},
			VerifyBtn(){
				this.isShowPop=true
				this.CodeBtnColor="#e43730"
			},
			closeMyself(){
				this.isShowPop=false
			},
		
			
		}
	}
</script>

<style scoped="scoped">
@import "../assets/css/nav.css"

	
</style>