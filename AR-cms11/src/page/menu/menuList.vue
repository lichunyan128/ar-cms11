<template>
	<div class="menuList">
		<div class="menuContent">
			<div class="seekBox clearfix">
				<my-seek @on-focus="focus"></my-seek>
				<div class="addClass" @click="addClassify"><em class="LightGrayFont">+</em><i>添加分类</i></div>
			</div>
			<ul class="MenuList">
				<li v-for="item in dishList"
					v-dragging="{ item: item, list: dishList, group: 'item' }"
          			>
					<p class="mainCourse">{{item.dish_type_name}}</p>
					<p class="addCourse LightGrayFont">
						<span class="addCourse LightGrayFont">{{"添加菜品"}}</span>
						<span>{{item.soldout_count}}</span>&nbsp;<span>{{item.unshelve_count}}</span>
					</p>
					<p class="icon" @click="addDish"></p>
				</li>
			</ul>
		</div>
		<div class="sort footBtn redBtn" @click="SortBtn">{{sort}}</div>
		<!--弹窗-->
		<div class="popUp-cover" v-if="isShowPop">
		 	<transition name="drop">
			 	<div class="popUp-content">
			 		<input type="text" placeholder="分类名称" v-model="dishName" />
			 		<div class="chooseBtn">
			 			<div class="yellowBtn" @click="Deselect">取消</div>
			 			<div class="redBtn" @click="Complete">完成</div>
			 		</div>
			 	</div>
			</transition>
		</div>
	</div>
</template>

<script>
	import seek from '../../components/seek'
	export default{
		components:{
		  	MySeek:seek
		  },
		data(){
			return{
				isShowPop:false,
				sort:'排序',
				dishName:'',
				dishList:[],
				
			}
		},
		created(){
			let that = this
			that.$http({
				method:'post',
				url:'/api/ssmtm/arpzDish/getArpzDishType.action',
				params:{
					'arpz_id':249,
					'arpz_uuid':'arpz~7e7a67e5-3342-46e4-bc86-81b943544bfb',
				}
			})
			.then(function(msg){
				that.dishList = msg.data
				console.log(msg.data)
			})
		},
		methods:{
			focus(){
				this.$router.push({name:'DishMenu_searchDish'})
			},
			addDish(){
				this.$router.push({name:'DishMenu_dishList'})
			},
			addClassify(){
				this.isShowPop = true
			},
			Deselect(){
				this.isShowPop = false
			},
			Complete(){
				this.isShowPop = false
				let disname = {
					dish_type_name: this.dishName,
			        soldout_count: '',
			        unshelve_count: ''
				}
				this.dishList.unshift(disname)
				console.log(disname)
			},
			SortBtn(){
				if(this.sort=='排序'){
					this.sort='完成'
				}else if(this.sort=='完成'){
					this.sort='排序'
				}
			}
		}
	}
</script>

<style>
	@import"../../assets/css/dishMenu.css";
</style>