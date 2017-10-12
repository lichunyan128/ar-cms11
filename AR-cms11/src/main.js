// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import axios from "axios"
import VueDND from "awe-dnd"

Vue.use(VueDND)
//import store from './vuex/store'
import flexible from '../build/flexible.js'
import {arpzSetLIEncrypt,getLIMobile,getLIVoucher,getLIGetRom} from './assets/js/new_file'

Vue.prototype.$http = axios;
Vue.config.productionTip = false



// 单独的userId  存储一下
var userIdValue = sessionStorage.getItem("userId");
if(userIdValue) {
	store.commit(types.userId, JSON.parse(userIdValue))
}

//权限
function hasPermission(roles, permissionRoles) {
  // console.log(!permissionRoles)
  if (roles.indexOf('0') >= 0) return true;
  if (!permissionRoles) return true;
  return roles == 0
}
router.beforeEach((to,from,next) => {
//console.log('to:',to);
//console.log('from',from);
//console.log('next',next);

	if(from.name != null && to.name == 'Login'){
		if(from.name == 'retrieve_password') {
			next();
		}else if(from.name == 'Protocal'){
			next();
		}else{
			next(false);
		}
	}else{
		next();
	}
	
	if (to.meta.requireAuth) {
   		if(!isEmptyObject(store.state.user)) {
   			if(hasPermission(store.state.user.userIdEntity,to.meta.jurisdiction)){
   				console.log(store.state.user.userIdEntity)
          		next()
	        }else{
	         	next ({path : "/404"})
	     	}
   		}else {
// 			console.log(store)
   			next({
   				name: 'Login'
		    })
   		}
   	}
})

function isEmptyObject(obj) {
 	for (var key in obj) {
 		return false;
 	}
 	return true;
 }


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  template: '<App/>',
  components: { App }
})


