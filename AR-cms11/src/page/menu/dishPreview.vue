<template>
	<div class="dishDetails">
		<div class="menuContent">
			<ul class="dishDetails_greens">
				<li class="greensPic">
					<img src="../../assets/img/default_dish_details_greens_pic@2x.png"/>
				</li>
				<li class="greensName">宫保鸡丁</li>
				<li class="greensPrice">￥88888888</li>
			</ul>
			<ul class="greensDescribe">
				<li class="DescribeTitle">菜品描述</li>
				<li class="DescribeText1">
					<span>推荐品</span>
					<span>可打折</span>
					<span>辣</span>
				</li>
				<li class="DescribeText2">
					推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣
					推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣推荐品可打折辣
				</li>
			</ul>
			<ul class="soldOut">
				<li class="DescribeTitle">下架设置</li>
				<li class="DescribeText1">
					<span>五天后自动售完</span>
					<span>未下架</span>
				</li>
			</ul>
			<ul class="curbSales">
				<li class="DescribeTitle">每日限售</li>
				<li class="DescribeText1">
					<span>限售1份</span>
				</li>
			</ul>
		
		</div>
		<div class="compile footBtn redBtn" @click="Compile">编 辑</div>
	</div>
</template>

<script>
	export default{
		data(){
			return{
				
			}
		},
		methods:{
			Compile(){
				this.$router.push({name:'DishMenu_complieDish'})
			}
		}
	}
</script>

<style>
	@import"../../assets/css/dishMenu.css"
</style>