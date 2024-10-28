<template>
    <div>
      <h1>楽天商品検索</h1>
      <input v-model="keyword" placeholder="商品を検索" />
      <button @click="searchProducts">検索</button>
  
      <ul v-if="products.length > 0">
      <li v-for="product in products" :key="product.itemCode">
        <img :src="product.mediumImageUrls[0]" alt="商品画像" />
        <p>{{ product.itemName }}</p>
        <p>価格: {{ product.itemPrice }}円</p>
        <a :href="product.itemUrl" target="_blank">商品ページへ</a>
      </li>
    </ul>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        keyword: '',
        products: []
      };
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
      }
    }
  };
  </script>
  
  <style scoped>
  ul {
    list-style-type: none;
    padding: 0;
  }
  li {
    margin: 10px 0;
  }
  img {
    max-width: 100px;
    height: auto;
  }
  </style>
  