<template>
  <div>
    <nav class="navbar">
      <div class="app-name">
        <img src="@/assets/logo.png" alt="AppName" class="app-logo" />
      </div>

      <div class="search-bar">
        <input v-model="keyword" placeholder="keyword" />
        <button @click="searchProducts"><img src="@/assets/symbol064.png" alt="AppName" class="search" /></button>
      </div>
    </nav>


    <div>
      <div v-if="isAuthenticated" class="auth-info">
        <div>Welcome, {{ currentUser.email }}</div>
        <div class="button2">
          <button @click="logout" class="auth-button1">Logout</button>
          <router-link to="/role2">
            <button class="auth-button1">To Supporter</button>
          </router-link>
        </div>
      </div>

      <div v-else class="auth-info">
        <button @click="$router.push('/users/sign_in')" class="auth-button1">Login</button>
        <router-link to="/role2">
          <button class="auth-button1">To Supporter</button>
        </router-link>
      </div>
    </div>



    <ul v-if="products.length > 0" class="product-list">
      <li v-for="product in products" :key="product.itemCode" class="product-item">
        <img :src="product.mediumImageUrls[0]" alt="商品画像" class="product-image" />
        <p>{{ product.itemName }}</p>
        <p>Price: {{ product.itemPrice }} yen</p>
          <p>Review: {{ product.reviewAverage }}/5</p>
          <a :href="product.itemUrl" target="_blank">To Product Page</a>

        <div class="desire-level-buttons">
          <button @click="saveDesireLevel(product, 3)" class="desire-button">Must Have!!</button>
          <button @click="saveDesireLevel(product, 2)" class="desire-button">Would Like</button>
          <button @click="saveDesireLevel(product, 1)" class="desire-button">Nice to Have</button>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
import { mapGetters } from 'vuex';

export default {
  data() {
    return {
      keyword: '',
      products: []
    };
  },
  computed: {
    ...mapGetters(['isAuthenticated', 'currentUser'])
  },
  mounted() {
    console.log('現在のユーザー:', this.currentUser); // ユーザー情報が正しく表示されるはずです
    console.log('認証状態:', this.isAuthenticated); // 認証状態が正しいか確認
  },
  methods: {
    async searchProducts() {
      try {
        const response = await axios.get('http://localhost:3000/products/search', {
          params: {
            keyword: this.keyword
          }
        });
        console.log(response.data);  // レスポンスを確認
        this.products = response.data;
      } catch (error) {
        console.error('APIリクエストに失敗しました:', error);
      }
    },

    logout() {
      this.$store.dispatch('logout');
      this.$router.push('/products/search');
    },

    async saveDesireLevel(product, level) {
      console.log('現在のユーザー:', this.currentUser); // 追加：ユーザー情報をログに表示
      console.log('保存する商品データ:', product); // 商品データをログに表示

      if (!this.currentUser) {
        console.error('ユーザーがログインしていません。');
        return;
      }

      try {
        const response = await axios.post('http://localhost:3000/user_products', {
      user_product: {
        user_id: this.currentUser.id,
        product_name: product.itemName,
        item_url: product.itemUrl,
        image_url: product.mediumImageUrls[0],
        price: product.itemPrice,
        review_score: product.reviewAverage,
        desire_level: level,
        gender: this.currentUser.gender,
        age: this.currentUser.age,
        prefecture: this.currentUser.prefecture,
        city: this.currentUser.city
      }
});

    console.log('欲しいBusshiが保存されました:', response.data);
    alert('欲しいBusshiが保存されました');
  } catch (error) {
    console.error('Error saving desire level:', error.response ? error.response.data : error.message);
    alert('データ保存に失敗しました');
  }
}
  }
};
</script>

<style scoped>

nav {
  height: 125px;
  background-color: #ffffff;
  /* padding: 0 20px; */
  display: flex;
  align-items: center;
  justify-content: space-between;
  border-bottom: 2px solid #ccc;
  box-sizing: border-box;
}

.search {
  width: 30px;
  height: 100%;
}


.app-name {
  /* margin-right: auto; */
  width: 125px;
  height: 125px;
  overflow: hidden;
}

.app-logo {
  padding: 10px;
  width: 100%;
  height: 100%;
  object-fit: cover; /* 画像をコンテナに合わせてカバーする */
  /* object-position:; 画像を中央に配置する */
}

.nav-links {
  display: flex;
  list-style: none;
}

.nav-links li {
  margin: 0 15px;
}

.auth-info {
  display: flex;
  align-items: center;
  width: 100%;
  justify-content: space-between; /* 左右に要素を配置 */
  /* gap: 10px; 要素間のスペースを調整 */
}

.button2 {
  display: flex;
  /* gap: 10px; ボタン間のスペースを調整 */
}



.auth-button {
  /* margin-left: 10px; */
  padding: 6px 12px;
  font-size: 14px;
  background-color: #007bff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.auth-button1 {
  /* margin-left: 10px; */
  padding: 6px 12px;
  font-size: 14px;
  background-color: #ffb26a;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.auth-button:hover {
  background-color: #0056b3;
}


.search-bar {
  display: flex;
  align-items: center;
  margin-right: 10px;
}

.search-bar input {
  padding: 6px;
  font-size: 14px;
  /* margin-right: 10px; */
  border-radius: 4px;
  border: 1px solid #ccc;
}

.search-bar button {
  padding: 6px 12px;
  font-size: 14px;
  background-color: #ffffff;
  color: white;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.search-bar button:hover {
  background-color: #ffffff;
}

ul.product-list {
  list-style-type: none;
  padding: 0;
  margin: 0 auto;
  max-width: 80%;
}

li.product-item {
  margin-bottom: 20px;
  background-color: hsl(33, 100%, 96%);
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding: 15px;
}

.product-image {
  max-width: 100%;
  margin-bottom: 10px;
}

.desire-level-buttons {
  display: flex;
  flex-direction: column;
}

.desire-level-buttons button {
  margin-top: 5px;
  padding: 6px 15px;
  font-size: 14px;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

.desire-level-buttons .rated-button {
  background-color: gray;
  cursor: not-allowed;
}

.desire-level-buttons .rated-button:hover {
  background-color: gray;
}

.desire-level-buttons button:not(.rated-button) {
  background-color: #007bff;
  color: white;
}

.desire-level-buttons button:not(.rated-button):hover {
  background-color: #0056b3;
}

ul.product-list {
  list-style-type: none;
  padding: 0;
  margin: 0 auto;
  max-width: 80%;
  padding-top: 20px;
}

ul.product-list2 {
  list-style-type: none;
  padding: 0;
  margin: 0 auto;
  max-width: 95%;
}


li.product-item {
  margin-bottom: 20px;
  background-color: hsl(33, 100%, 96%);
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  padding: 15px;
}

ul.product-list.grid-view {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
}

li.product-item.grid-item {
  flex: 0 0 calc(50% - 20px); /* 横に2つ並べる場合 */
  margin-bottom: 20px;
  margin-right: 10px;
  margin-left: 10px;
}


</style>