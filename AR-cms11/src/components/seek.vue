<template>
	<div class="seek">
		<input type="text" class="huntText" placeholder="请输入菜名" v-model="inputText" @click="textFocus" @focus="focus"/></input>
		<span class="deltext" :style="{display:hit}" @click="deltext"></span>
		<div class="huntBtn" @click="huntBtn">搜索</div>
	</div>
</template>

<script>
	export default{
		props:{
			isShow:{
				type:Boolean,
				default:false
			},
			
		},
		data () {
			return {
			     hit:'none',
			     inputText:''
			}
		},
		methods:{
			textFocus(){
				this.$emit('on-focus')
			},
			huntBtn(){
				this.$emit('on-huntBtn')
			},
			focus(){
				this.hit = 'block'
			},
			deltext(){
				this.inputText = ''
			}
		}
	}
</script>

<style>
.huntText{
	width: 6rem;
	height: 0.74rem;
	background: #f2f2f0;
	border:none;
	border-top-left-radius:0.5rem;
	border-bottom-left-radius:0.5rem;
	position: relative;
	padding-left: 0.37rem;
	font-size: .32rem;
}
.deltext{
	background: url(../assets/img/seek_close@2x.png)no-repeat;
	background-size:100% 100% ;
	display: inline-block;
	width: .3rem;
	height: .3rem;
	position: absolute;
	right: 2.1rem;
	top: 0.98rem;
}
.huntBtn{
	width: 1.57rem;
	height: 0.74rem;
	line-height: 0.74rem;
	text-align: center;
	color: #fff;
	font-size:0.32rem;
	background: #e53530;
	border:none;
	border-top-right-radius:0.5rem;
	border-bottom-right-radius:0.5rem;
	position: absolute;
	top:0.74rem;
	right:.3rem;
}
</style>