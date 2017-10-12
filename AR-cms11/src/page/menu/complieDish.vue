<template>
	<div class="complieDish">
		<div class="menuContent">
			<form method="post">
				<ul class="complieTop">
					<li class="addPic">
						<span>添加菜品图片</span>
						<input type="file" />
					</li>
					<li><input type="text" placeholder="请输入菜名" v-model="dishName"></li>
					<li><input type="text" placeholder="请输入价格" v-model="dishPrice"></li>
				</ul>
				<ul class="compileContent">
					<li>
						<div>是否为推荐品</div>
						<div><input type="radio" name="introductory" />是</div>
						<div><input type="radio" name="introductory" />否</div>
					</li>
					<li>
						<div>是否可打折</div>
						<div><input type="radio" name="discount" />是</div>
						<div><input type="radio" name="discount" />否</div>
					</li>
					<li>
						<div>是否辣</div>
						<div><input type="radio" name="chili" />是</div>
						<div><input type="radio" name="chili" />否</div>
					</li>
					<li>
						<textarea placeholder="请输入描述，告诉未来的回头客们，你优质的菜品原料，和独特的风味吧！"></textarea>
					</li>
				</ul>
				<ul class="compileContent">
					<li class="sellOut LightGrayFont">设置自动售完或下架</li>
					<li>
						<div>自动售完<img></img></div>
						<div><input type="radio" name="introductory" />是</div>
						<div><input type="radio" name="introductory" />否</div>
					</li>
					<li>
						<div>每日限售</div>
						<div></div>
					</li>
					<li>
						<div>下架</div>
						<div><input type="radio" name="chili" />是</div>
						<div><input type="radio" name="chili" />否</div>
					</li>
					<li>
						<div>设置规格</div>
						<div><input type="radio" name="chili" />是</div>
						<div><input type="radio" name="chili" />否</div>
					</li>
				</ul>
			</form>
		</div>
		<div class="finish footBtn redBtn" @click="Finish">完 成</div>
	</div>
</template>

<script>
	export default{
		data(){
			return{
				dishName:'',
				dishPrice:''
			}
		},
		methods:{
			Finish(){
				this.$router.push({name:'DishMenu_dishList'})
			},
		}
	}
</script>

<style>
	@import"../../assets/css/dishMenu.css"
</style>