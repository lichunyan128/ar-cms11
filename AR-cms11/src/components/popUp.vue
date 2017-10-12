<template>
	<div class="popUp">
		 <div class="popUp-cover" v-if="isShow">
		 	<transition name="drop">
			 	<div class="popUp-content">
			 		<div v-if="nulVal" class="popUp-text">请输入验证码！</div>
			 		<div v-if="vaLen" class="popUp-text">验证码错误！</div>
			 		<div v-if="sucval" class="popUp-text">验证成功！</div>
			 		<input type="button" value="好" @click="closeMyself"></input>
			 	</div>
			 </transition>
		 </div>
		 
	</div>
</template>

<script>
	export default{
		name:'popUp',
		props:{
			isShow:{
				type:Boolean,
				default:false
			},
			value:'',
//			vaLen:false,
//			nulVal:false,
//			sucval:false
		},
//		methods:{
//			closeMyself(){
//				this.$emit('on-close')
//			}
//		}
	}
</script>

<style>
	.popUp-cover{
		background: rgba(0,0,0,0.5);
		position: fixed;
		z-index: 5;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
	}
	.popUp-content{
		width: 60%;
		height:16%;
		position: absolute;
		top:50%;
		left:50%;;
		margin-left:-30%;
		margin-top:-25%;
		background:#fff;
		z-index: 10;
		border-radius:0.25rem;
	}
	.popUp-text{
		font-size: 0.3rem;
		font-weight: 600;
		height:1.3rem;
		line-height: 1.3rem;
		text-align: center;
		border-bottom:1px solid #393939;
		color: #393939;
	}
	input{
		height: 0.7rem;
		line-height: .75rem;
		width:4.3rem;
		border:none;
		background:none;
		font-size:.3rem;
		font-weight: 600;
		color:#109eb8;
	}
</style>