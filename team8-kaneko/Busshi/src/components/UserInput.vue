<template>
    <div>
      <h1>ユーザー登録</h1>
  
      <!-- エラーメッセージを表示 -->
      <div v-if="errors.length">
        <ul>
          <li v-for="(error, index) in errors" :key="index" style="color: red;">
            {{ error }}
          </li>
        </ul>
      </div>
  
      <form @submit.prevent="registerUser">
        <div>
          <label for="email">メールアドレス:</label>
          <input id="email" type="email" v-model="user.email" required>
        </div>
        <div>
          <label for="password">パスワード:</label>
          <input id="password" type="password" v-model="user.password" required>
        </div>
        <div>
          <button type="submit">登録</button>
        </div>
      </form>
    </div>
  </template>
  
  <script>
  import axios from 'axios';
  
  export default {
    data() {
      return {
        user: {
          email: '',
          password: ''
        },
        errors: [] // ここで空の配列として初期化します
      };
    },
    methods: {
      async registerUser() {
        this.errors = []; // 以前のエラーをクリア
        console.log('送信するユーザーデータ:', this.user);
        try {
          const response = await axios.post('http://localhost:3000/users', {
            user: this.user
          });
          console.log('登録成功:', response);
        } catch (error) {
          if (error.response && error.response.data.errors) {
            this.errors = error.response.data.errors; // エラーメッセージを格納
          } else {
            console.error('登録エラー:', error);
          }
        }
      }
    }
  };
  </script>
  