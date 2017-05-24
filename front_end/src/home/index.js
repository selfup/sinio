import axios from 'axios';
import Vue from 'vue/dist/vue';

const vm = new Vue({
  el: '#app',
  data() {
    return {
      pins: [],
    };
  },
  methods: {
    flipPin() {
      return null;
    },
  },
  created() {
    axios.get('/pins')
      .then((res) => {
        this.pins = res.data;
      })
      .catch((err) => {
        throw new Error(err);
      });
  },
});

export default vm;
