<template>
  <div id="app">
  	<div class="main-title">
  		<div class="back" @click="backs" v-show="this.$router.currentRoute.name != 'Login'">返回</div>
  		<div v-show="this.$router.currentRoute.name != 'Login'">商户后台</div>
			<div class="jump" @click="closewebview(1)">关闭</div>
			
  	</div>
   <!-- <keep-alive  include！="/OrderDetail">--><!--添加缓存-->
  		<router-view></router-view>
  	<!--</keep-alive>-->
  </div>
</template>

<script>


export default {
  name: 'app',
  data(){
  	return {
  		backShow: true,
  	}
  },
  ready(){
//  console.log(this.$route);
  },
  methods: {
  	backs() {
  		history.go(-1);
  	},
  	closewebview(str) {
  		return str;//1是关闭
  	}
  }
}
</script>

<style>
/*@import "./assets/css/app.css"*/
html,
	body {border: 0;font-family: "PingFang-SC-Regular", "Helvetica-Neue", "Helvetica", Arial, sans-serif;
		margin: 0;padding: 0;color: #393939;background: #fff;}

div,span,object,iframe,img,table,caption,thead,tbody,tfoot,tr,tr,td,article,aside,
canvas,details,figure,hgroup,menu,nav,footer,header,section,summary,mark,audio,video {
		border: 0;margin: 0;padding: 0;font-size: .28rem;}

h1,h2,h3,h4,h5,h6,p,blockquote,pre,a,abbr,address,cit,code,del,dfn,em,ins,q,samp,small,strong,sub,
sup,b,i,hr,dl,dt,dd,ol,ul,li,fieldset,legend,label {
		border: 0;vertical-align: baseline;margin: 0;padding: 0;}

article,aside,canvas,figure,figure img,figcaption,hgroup,footer,header,nav,section,audio,video {
		display: block;
	}

table {border-collapse: separate;border-spacing: 0;caption,th,td {text-align: left;vertical-align: middle;}}
	li {list-style: none;border-bottom: 1px solid #e1e1e1;}
	a {text-decoration: none;outline: 0 none;}
	a img {border: 0;}
	:focus {outline: 0;}
	* {box-sizing: border-box;}

	textarea {resize: none;appearance: none;}
	select{appearance: none;background-color: #fff;}
	i {font-style: normal;}
	/*设置浏览器滚动条不可见*/
	::-webkit-scrollbar {width: 0;}
	.clearfix{
		content: "";
		display: block;
		/*height:0;*/ 
		clear: both;
		zoom : 1;}
	
.main-title{
		display: flex;
		flex-flow: row nowrap;
		justify-content: space-between;
		border-bottom: 1px solid #ebebeb;
		height: .88rem;
		line-height: .88rem;
		padding: 0 .3rem;
		background: #fff;
		width: 100%;
		position: fixed;
		top: 0;
		z-index: 44;
}
.router-link-exact-active{
		color: red !important;
	}

.back{
	font-size: .15rem;
}
.redFont{
		color: #e43730;
}
.yellowFont{
		color: #febe3a;
}
.redBtn{
		background: #e43730;
}
.yellowBtn{
		background: #febe3a;
}
.interval{
	height:0.1rem;
	background: #ededed;
}
.LightGrayFont{
	color:#a8a8a8;
}
.bottomBoder{
	border-bottom:1px solid #e1e1e1;
}
.footBtn{
	height: .98rem;
	line-height: .98rem;
	text-align: center;
	color: #fff;
}
	
</style>
