<template>
	<div class="Orderdetail">
		<div class="detailTop">
			<div class="goback">
				<router-link :to="{path:'/nav'}">商户后台<em></em></router-link>
			</div>
			<div class="logo">
				<div class="userPic"><img :src="'https://www.arpuzi.com/tripmaster/'+avatar"/></div>
			</div>
			<div class="logoName">{{nickname}}</div>
		</div>
		<ul  class="orderInfo">
			<li class="listTop LightGrayFont">订单信息</li>
			<li class="listItem">预订人<span>{{details.user_full_name}}</span></li>
			<li class="listItem">联系电话<span>{{details.phone_number}}</span></li>
			<li class="listItem">用餐时间<span>{{details.order_date}}</span></li>
			<li class="listItem">用餐人数<span>{{details.number_of_guests}}</span></li>
			<li class="listItem">订单时间<span>{{details.pay_time}}</span></li>
			<li class="listItem">支付方式<span>{{details.transaction_type}}</span></li>
			<li class="listItem">特殊要求<span>{{details.user_special_request}}</span></li>
		</ul>
		<ul  class="orderInfo orderDetail">
			<li class="listTop LightGrayFont">订单详情</li>
			<li class="DetailListItem" v-for="item in menuList">
				<p>{{item.dish_name}}</p>
				<p class="addRelish LightGrayFont" v-if="item.dinner_type==1"><span v-for="itemList in item.list_size"></span></p>
				<p class="addRelish LightGrayFont" v-if="item.dinner_type==2"><span v-for="itemList in item.list_size">{{itemList}}</span></p>
				<p class="addRelish LightGrayFont" v-if="item.dinner_type==3"><span v-for="itemList in item.list_size">{{itemList}}</span></p>
				<div class="priceNum">
					<span class="number">*{{item.count}}</span>
					<span>￥{{item.dish_total_price}}</span>
				</div>
			</li>
			<li class="listItem  totalVal">
				<i>总计￥{{details.transaction_cost}}</i><i class="discountPrice">优惠￥{{details.preferential_cost}}</i><i class="outOfPocket redFont">实付￥{{details.coupon_cost}}</i>
			</li>
		</ul>
	</div>
</template>

<script>
	export default{
		name:'Orderdetail',
		data(){
			return{
				avatar:"",
				nickname:'',
				orderId:'',
				serialNumber:'',
				details:{},
				menuList:[],
				listSize:[]
			}
		},
		created(){
			let that = this
			that.avatar = that.$route.query.avatar;
			that.nickname = that.$route.query.nickname;
			that.orderId = that.$route.query.orderId;
			that.serialNumber = that.$route.query.serialNumber;
			var mobile = localStorage.getItem("mobile");
	  		var voucher = localStorage.getItem("voucher");
	  		var random_str = localStorage.getItem("random_str");
	  		console.log(that.orderId,that.serialNumber)
			that.$http({
				method:'post',
				url:"/api/ssmtm/arpz/getArpzOrderDetails.action",
				params:{
					'mobile':mobile,
					'voucher':voucher,
					'random_str':random_str,
					'order_id':that.orderId,
					'serial_number':that.serialNumber,
				}
			})
			.then(function(msg){
				that.details = msg.data;
				that.menuList = msg.data.menu_list;
				console.log(that.menuList)
			})
			.catch(function(){
				console.log('出错了')
			});
		},
		methods:{
			
		}
	}
</script>

<style>
	@import "../../assets/css/orderDetail.css"

</style>