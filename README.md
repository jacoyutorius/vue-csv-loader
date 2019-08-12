# vue-csv-loader

Vue component to load CSV.

[![Image from Gyazo](https://i.gyazo.com/338e9c39b1fee39db63343c586b392b7.gif)](https://gyazo.com/338e9c39b1fee39db63343c586b392b7)

## install

```bash
npm install vue-csv-loader
```

## setup

**main.js**

```js
import VueCsvLoader from "vue-csv-loader";
Vue.use(VueCsvLoader);
```

**App.vue**

template

```html
<div id="app">
  <section>
    <csv-loader v-on:loadSuccess="loadSuccess"></csv-loader>
  </section>

  <section class="table-container">
    <table class="table is-bordered is-hoverable is-fullwidth">
      <thead>
        <tr v-for="(row, rowIndex) in csvHeader" v-bind:key="rowIndex">
          <td v-if="showCheckbox && rowIndex === 0">
            <input type="checkbox" />
          </td>
          <th v-for="(data, colIndex) in row" v-bind:key="colIndex">
            {{ data }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr v-for="(row, rowIndex) in csvBody" v-bind:key="rowIndex">
          <td v-if="showCheckbox">
            <input type="checkbox" @change="onCheckBoxCheck(row)" />
          </td>
          <td v-for="(data, colIndex) in row" v-bind:key="colIndex">
            {{ data }}
          </td>
        </tr>
      </tbody>
    </table>
  </section>
</div>
```

script

```js
import CsvLoader from "vue-csv-loader";
import "vue-csv-loader/dist/csv-loader.css";

export default {
  name: "app",
  components: {
    CsvLoader
  },
  data: function() {
    return {
      showCheckbox: true,
      csvHeader: [],
      csvBody: []
    };
  },
  methods: {
    loadSuccess: function(result) {
      this.csvHeader = result.csvHeader;
      this.csvBody = result.csvBody;
    },
    onCheckBoxCheck: function(row) {
      console.log(row);
    }
  }
};
```
