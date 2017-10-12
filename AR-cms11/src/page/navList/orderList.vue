<template>
	<div class="orderlist">
		<router-view></router-view>
		<!--<div>-->
			<ul class="banner">
				<li class="sort LightGrayFont" @click="dinnerTime">{{dinnerMdel}}<em class="chooseIco" :style="{transform:byChoose}"></em></li>
				<li class="sort LightGrayFont" @click="cycleShow">{{cycleModel}} <em class="chooseIco" :style="{transform:cycleByChoose}"></em></li>
			</ul>
			<div  class="chooseIcon" :class="{ chooseLeft: chooseLeft}"></div>
			<div  class="chooseIcon" :class="{ chooseRight: chooseRight}"></div>
			<div class="listBox">
				<ul class="innerBox" v-for="(listItme,index) in orderList" @click="ListDetails(index,listItme)">
					<li class="listTop ">
						支付时间：{{listItme.pay_time}}
					</li>
					<li class="listUserInfo">
						<div class="headPic">
							<img :src="'https://www.arpuzi.com/tripmaster/'+listItme.avatar"/>
						</div>
						<div class="userName">{{listItme.nickname}}</div>
						<div class="basicInformation">
							<p>预计到店时间:&nbsp;<span>{{listItme.nickname}}</span></p>
							<p>
								<span>桌号：<i>{{listItme.arpz_desk_id}}</i></span>
								<span class="peopleNum">人数：<i>{{listItme.number_of_guests}}</i></span>
							</p>
							
						</div>
						<div class="listPrice">
							<p class="realPrice">￥{{listItme.coupon_cost}}</p>
							<p class="priceFontColor">￥{{listItme.transaction_cost}}</p>
						</div>
					</li>
					<li class="listFoot clearfix">
						<p v-if="listItme.order_state==0">未完成<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==6">已过期<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==2">取消<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==3">已验证<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==4">退款中<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==5">已退款<span class="time">{{listItme.yz_time}}</span></p>
						<p v-if="listItme.order_state==1">退款失败<span class="time">{{listItme.yz_time}}</span></p>
					</li>
				</ul>
				<ul class="paging">
					<li @click="prev"><上一页</li>
					<li @click="next">下一页></li>
				</ul>
			</div>
			
			<ul class="totalMoney yellowBtn footBtn">
				<li>验证（已收款）金额：<i>{{money.total_money}}</i></li>
				<li>验证（已收款）订单：<i>{{money.total_order_count}}</i></li>
			</ul>
			<!--弹框-->
			<div class="popListBox" v-show="dinner" @click="dinnerPop">
				<ul class="popList">
					<li v-for="(item,index) in dinnerList" @click="dinnerSort(index,item)" :class="{'active':dinnerFlag==index}">{{item.name}}</li>
				</ul>
			</div>
			<div class="popListBox" v-show="cycle" @click="cyclePop">
				<ul class="popList">
					<li v-for="(item,index) in cycleList" @click="cycleSort(index,item)" :class="{'active':cycleFlag==index}">{{item.name}}</li>
				</ul>
			</div>
		<!--</div>-->
	</div>
</template>

<script>
	export default{
		name:'orderlist',
		data(){
			return{
				dinnerMdel:'按照就餐时间',
				cycleModel:'全部',
				dinnerVal:'order_date',
				cycleVal:'-1',
				byChoose:'rotate(-135deg)',
				cycleByChoose:'rotate(-135deg)',
				chooseLeft:false,
				chooseRight:false,
				dinner:false,
				cycle:false,
				dinnerFlag: false,
				cycleFlag: false,
				dinnerList: [
			        {
			          name: '按照就餐时间',
			          value: 'order_date',
			        },
			        {
			          name: '按照支付时间',
			          value: 'pay_time',
			        },
			        {
			          name: '按照金额',
			          value: 'money',
			        },
			        {
			          name: '按照验证时间',
			          value: 'verify_time',
			        }
			      ],
			    cycleList: [
			        {
			          name: '全部',
			          value: -1,
			        },
			        {
			          name: '当天',
			          value: 1,
			        },
			        {
			          name: '一周内',
			          value: 7,
			        },
			        {
			          name: '一个月内',
			          value: 30,
			        }
			      ],
			      
			    orderList:[],
			    money:'',
			    pageNum:1
			}
		},
		created(){
			let that = this
			var mobile = localStorage.getItem("mobile");
	  		var voucher = localStorage.getItem("voucher");
	  		var random_str = localStorage.getItem("random_str");
	  		that.dinnerVal = 'order_date';
			that.cycleVal=-1;
			that.$http({
				method:'post',
				url:"/api/ssmtm/arpz/getArpzOrder.action",
				params:{
					'mobile':mobile,
					'voucher':voucher,
					'random_str':random_str,
					'order_method':that.dinnerVal,
					'days':that.cycleVal,
					'arpz_uuid':'arpz~7e7a67e5-3342-46e4-bc86-81b943544bfb',
					'page':1,
				}
			})
			.then(function(msg){
				that.money = msg.data;
				that.orderList = msg.data.list_aor;
					console.log(that.orderList)
			})
			.catch(function(){
				console.log('出错了')
			});
		},
		methods:{
			dinnerTime(){
				this.dinner=true
				this.cycle=false
				this.byChoose='rotate(45deg)'
				this.cycleByChoose='rotate(-135deg)'
				this.chooseLeft=true
				this.chooseRight=false
			},
			cycleShow(){
				this.cycle=true
				this.dinner=false
				this.cycleByChoose='rotate(45deg)'
				this.byChoose='rotate(-135deg)'
				this.chooseLeft=false
				this.chooseRight=true
			},
			//按照就餐时间
			dinnerSort(index,item){
				let that = this
				that.dinnerFlag=index
				that.dinnerMdel = item.name
				that.dinner = false
				that.dinnerVal = item.value
				arpzSetLIEncrypt("18500465533", "123123");
		  		var mobile = localStorage.getItem("mobile");
		  		var voucher = localStorage.getItem("voucher");
		  		var random_str = localStorage.getItem("random_str");
				that.$http({
					method:'post',
					url:"/api/ssmtm/arpz/getArpzOrder.action",
					params:{
						'mobile':mobile,
						'voucher':voucher,
						'random_str':random_str,
						'order_method':that.dinnerVal,
						'days':that.cycleVal,
						'arpz_uuid':'arpz~8e82a11e-3a8c-48e2-9bdc-72b6b961acf2',
						'page':1,
					}
				})
				.then(function(msg){
//					console.log(mobile)
					that.money = msg.data;
					that.orderList = msg.data.list_aor;
				})
				.catch(function(){
					console.log('出错了')
				});
			},
			//时间段
			cycleSort(index,item){
				let that = this
				that.cycleFlag=index
				that.cycleModel = item.name
				that.cycle=false
				that.cycleVal = item.value
				console.log(that.dinnerVal,that.cycleVal)
				arpzSetLIEncrypt("18500465533", "123123");
		  		var mobile = localStorage.getItem("mobile");
		  		var voucher = localStorage.getItem("voucher");
		  		var random_str = localStorage.getItem("random_str");
				that.$http({
					method:'post',
					url:"/api/ssmtm/arpz/getArpzOrder.action",
					params:{
						'mobile':mobile,
						'voucher':voucher,
						'random_str':random_str,
						'order_method':that.dinnerVal,
						'days':that.cycleVal,
						'arpz_uuid':'arpz~8e82a11e-3a8c-48e2-9bdc-72b6b961acf2',
						'page':1,
					}
				})
				.then(function(msg){
					that.money = msg.data;
					that.orderList = msg.data.list_aor;
					console.log(that.orderList)
				})
				.catch(function(){
					console.log('出错了')
				});
			},
			//分页
			prev(){//上一页
				let that = this
				arpzSetLIEncrypt("18500465533", "123123");
		  		var mobile = localStorage.getItem("mobile");
		  		var voucher = localStorage.getItem("voucher");
		  		var random_str = localStorage.getItem("random_str");
		  		let prevPage = that.pageNum
		  		if(prevPage<=1){
		  			prevPage==1
		  		}else{
		  			prevPage--
		  		}
		  		that.pageNum=prevPage
				that.$http({
					method:'post',
					url:"/api/ssmtm/arpz/getArpzOrder.action",
					params:{
						'mobile':mobile,
						'voucher':voucher,
						'random_str':random_str,
						'order_method':that.dinnerVal,
						'days':that.cycleVal,
						'arpz_uuid':'arpz~8e82a11e-3a8c-48e2-9bdc-72b6b961acf2',
						'page':that.pageNum,
					}
				})
				.then(function(msg){
					that.money = msg.data;
					that.orderList = msg.data.list_aor;
					console.log(that.orderList)
					console.log(that.pageNum)
				})
				.catch(function(){
					console.log('出错了')
				})
			},
			next(){//下一页
				let that = this
				arpzSetLIEncrypt("18500465533", "123123");
		  		var mobile = localStorage.getItem("mobile");
		  		var voucher = localStorage.getItem("voucher");
		  		var random_str = localStorage.getItem("random_str");
		  		let nextPage=that.pageNum;
		  		let orderListLength = that.orderList.length;
		  		if(orderListLength>=20){
		  			nextPage++
		  		}
		  		that.pageNum=nextPage
				that.$http({
					method:'post',
					url:"/api/ssmtm/arpz/getArpzOrder.action",
					params:{
						'mobile':mobile,
						'voucher':voucher,
						'random_str':random_str,
						'order_method':that.dinnerVal,
						'days':that.cycleVal,
						'arpz_uuid':'arpz~8e82a11e-3a8c-48e2-9bdc-72b6b961acf2',
						'page':that.pageNum,
					}
				})
				.then(function(msg){
					that.money = msg.data;
					that.orderList = msg.data.list_aor;
					console.log(that.orderList)
					console.log(that.pageNum)
				})
				.catch(function(){
					console.log('出错了')
				})
			},
			
			dinnerPop(){
				this.dinner = false
			},
			cyclePop(){
				this.cycle = false
			},
			ListDetails(index,listItme){
				let that = this;
				that.$router.push({name:'OrderDetail',query:{avatar:listItme.avatar,nickname:listItme.nickname,orderId:listItme.order_id,serialNumber:listItme.serial_number}})
			}
		}//methods
	}
</script>

<style scoped="scoped">
	@import "../../assets/css/orderList.css"
	
</style>