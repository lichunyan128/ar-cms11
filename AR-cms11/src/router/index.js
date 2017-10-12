import Vue from 'vue'
import Router from 'vue-router'
import Error from '@/page/error'
import Login from '@/page/Login'
import Protocal from '@/page/login/protocal';
import Confirm from '@/page/login/confirm';
import Password from '@/page/login/retrieve_password';
import Nav from '@/page/nav';
import OderList from '@/page/navList/orderList';
import CouponUseInfo from '@/page/navList/couponUseInfo';
import DishMenu from '@/page/navList/dishMenu';
import DishMenu_MenuList from '@/page/menu/menuList';
import DishMenu_searchDish from '@/page/menu/searchDish';
import DishMenu_dishList from '@/page/menu/dishList';
import DishMenu_dishPreview from '@/page/menu/dishPreview';
import DishMenu_complieDish from '@/page/menu/complieDish';
import CouponList from '@/page/navList/couponList';
import OrderDetail from '@/page/navList/orderDetail';
Vue.use(Router)

export default new Router({
	mode: 'history',
  routes: [
  {
		name: 'Error',
		path: '/error',
		component: Error
	},
    {
      path: '/',
      name: 'Login',
      component: Login
    },
	{
		name: 'Protocal',
		path: '/login/protocal',
		component: Protocal
	},
	{
		name: 'retrieve_password',
		path: '/login/retrieve_password',
		component: Password
	},
	{
		name: 'confirm',
		path: '/login/confirm',
		component: Confirm
	},
	{
		name: 'nav',
		path: '/nav',
		component: Nav
	},
	{
		name: 'orderList',
		path: '/navList/orderList',
		component: OderList,
	},
	{
		name: 'OrderDetail',
		path: '/navList/orderDetail',
		component: OrderDetail
	},
	{
		name: 'couponUseInfo',
		path: '/navList/couponUseInfo',
		component: CouponUseInfo,
	},
	{
		name: 'dishMenu',
		path: '/navList/dishMenu',
		component: DishMenu,
		redirect:'/navList/dishMenu/menuList',
		children:[
			{
				path:'menuList',
				name:'DishMenu_MenuList',
				component:DishMenu_MenuList
			},
			{
				path:'searchDish',
				name:'DishMenu_searchDish',
				component:DishMenu_searchDish
			},
			{
				path:'dishList',
				name:'DishMenu_dishList',
				component:DishMenu_dishList
			},
			{
				path:'complieDish',
				name:'DishMenu_complieDish',
				component:DishMenu_complieDish
			},
			{
				path:'dishPreview',
				name:'DishMenu_dishPreview',
				component:DishMenu_dishPreview
			},
		]
	},
	{
		name: 'couponList',
		path: '/navList/couponList',
		component: CouponList
	},
	
	
	
  ]
})
