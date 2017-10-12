<template>
	<div class="searchDish">
		<div class="menuContent">
			<div class="searchDish_seekBox clearfix">
				<my-seek @on-huntBtn="huntBtn"></my-seek>
			</div>
			<ul class="searchDish_list">
				<li @click="DishDetails()"><p>甜点</p><p class="icons"></p></li>
				<li><p>甜点</p><p class="icons"></p></li>
				<li><p>甜点</p><p class="icons"></p></li>
			</ul>
		</div>
	</div>
</template>

<script>
	import seek from '../../components/seek';
	export default {
		components:{
			MySeek:seek
		},
		data(){
			return{
				
			}
		},
		created(){
			
		},
		methods:{
			huntBtn(){
				
			},
			DishDetails(){
				let that = this;
//				that.$router.push({name:'OrderDetail',query:{avatar:listItme.avatar}})
			}
		}
		
	}
</script>

<style>
	@import"../../assets/css/dishMenu.css"
	
</style>