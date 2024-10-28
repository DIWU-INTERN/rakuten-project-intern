<template>
    <div>
        <!-- Vueでフォーム送信時のイベント設定をしたいときにv-on(@)を用いる -->
        <!-- フォーム送信アクションでonSubmitFormmメソッドを呼び出す -->
        <form @submit="onSubmitForm">
            <label>やること<input type="text" v-model="input"></label>
            <label>期限<input type="date" v-model="inputDate"></label>
            <input type="submit" value="登録" />
        </form>
    </div>
</template>

<script setup>
    import { ref } from "vue";
    import { statuses} from "../const/statuses"

    // v-modelを使って双方向バインディングを用いたいのでref関数を用いる
    const input = ref("")
    const inputDate = ref("")


    function onSubmitForm() {
        console.log(input.value)

        // localstrage.getitem(key)でローカルストレージから取り出す
        // json.parseで配列に変換
        //  もしローカルストレージがからの場合は空の配列として宣言
        const items = JSON.parse(localStorage.getItem("items")) || [];

        //保存するタスクのオブジェクト
        const newItem = {
            id: items.length,//整番
            content: input.value,//内容
            limit: inputDate.value,//しみ切りび
            state: statuses.NOT_START,//状態
            onEdit: false//編集中フラグ
        }

        // 先ほど取得したitems(配列)に追加（push）
        items.push(newItem)

        // 配列をローカルストレージに保存
        //配列を文字列に変換してから引数に渡す
        localStorage.setItem("items", JSON.stringify(items))

    }

</script>