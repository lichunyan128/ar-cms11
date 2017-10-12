<template>
	<div class="protocal-content">
		<div>
			<div class="new-password"><span>新密码</span><input type="text" placeholder="请输入新密码"/></div>
			<div class="new-password"><span class="suerPassword">确认新密码</span><input type="text" placeholder="请再次输入密码"/></div>
		</div>
		<div>
			<button @click="" id="confirm">确认</button>
		</div>
	</div>
</template>

<script>
export default{
	name:'confirm',
	data() {
		return {}
	},
	methods: {
		submit() {
			
		},
		toLogin() {
			
		}
	}
}
</script>

<style>
	*{padding: 0;margin: 0;}
	.protocal-content{
		padding: .18rem;
		padding-top: .9rem;
		margin-top: 1rem;
	}
	.new-password {
		padding-bottom: .47rem;
		/*font-size: .28rem;*/
		border-bottom: 1px solid #e1e1e1;
		margin-bottom: .45rem;
	}
	#confirm{
		width: 100%;
		background: #CD3333;
		color: #fff;
		text-align: center;
		border: none;
		height: .78rem;
		line-height: .78rem;
		font-size: .34rem;
	}
	input[type=text] {
		margin-left:.3rem;
		border: none;
	}
	span{
		display: inline-block;
		width: 1.3rem;
	}
	.suerPassword{
		width: 2rem;
	}
</style>