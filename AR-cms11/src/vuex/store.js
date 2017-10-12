import Vue from 'vue'
import Vuex from 'vuex'
import * as types from './types'
//import {set,get} from '../moudle/js/localStorage'
Vue.use(Vuex)

const state = {
	user:{},
	userId : "",
	userMenu : []
	// isAdmin : '',
}

const mutations = {
	[types.login_admin] : (state,user) => {	
		sessionStorage.setItem('_DB_user', JSON.stringify(user));
		state.user = user;  //存储登录信息
		console.log(state.user);
	},
	[types.login_business] : (state,user) => {	
		sessionStorage.setItem('_DB_user', JSON.stringify(user));
		state.user = user;  //存储登录信息
		console.log(state.user);
	},
	[types.logOut] : (state) => {   //清空信息
		sessionStorage.removeItem('_DB_user');
		sessionStorage.removeItem('userId');
		sessionStorage.removeItem('userMenu');
		state.user = null
		state.userId = null;
		state.userMenu = null;
	},
	[types.userId] : (state,user) => {
		sessionStorage.setItem('userId', JSON.stringify(user));				
		state.userId = user    //存userId
		console.log(state.userId);
	},
	[types.getMenu] : (state,userMenu) => {
		sessionStorage.setItem('userMenu', JSON.stringify(userMenu));				
		state.userMenu = userMenu    //userMenu
	}
	// [types.isAdmin] : (state,user) =>{
	// 	state.isAdmin = user   //切换左侧导航栏
	// }
}
export default new Vuex.Store({
	state,
	mutations
})
