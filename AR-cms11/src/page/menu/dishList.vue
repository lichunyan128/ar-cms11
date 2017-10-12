<template>
	<div class="dishList">
		<div class="menuContent">
			<div class="addDishBox">
				<div class="addDish" @click="AddDish"><em class="LightGrayFont">+</em><i>添加菜品</i></div>
			</div>
			<div class="listShow">
				<ul class="bottomBoder">
					<li class="dishName" @click="greenDetails" >拔丝奶豆腐</li>
					<li class="content">
						<div class="price">￥8888888</div>
						<div class="vendibility">设为可售</div>
						<div @click="GoComplie">编辑</div>
						<div>删除</div>
						<div>帮助</div>
					</li>
				</ul>
				<ul class="bottomBoder">
					<li class="dishName" @click="greenDetails" >拔丝奶豆腐</li>
					<li class="content">
						<div class="price">￥8888888</div>
						<div class="sellOut">设为售完</div>
						<div @click="GoComplie">编辑</div>
						<div>删除</div>
						<div>帮助</div>
					</li>
				</ul>
			</div>
			
		</div>
	</div>
</template>

<script>
	export default{
		data(){
			return{
				
			}
		},
		methods:{
			AddDish(){
				this.$router.push({name:'DishMenu_complieDish'})
			},
			greenDetails(){
				this.$router.push({name:'DishMenu_dishPreview'})
			},
			GoComplie(){
				this.$router.push({name:'DishMenu_complieDish'})
			}
		}
	}
</script>

<style>
	@import"../../assets/css/dishMenu.css"
</style>