<template>
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
            <th v-for="(data, colIndex) in row" v-bind:key="colIndex">{{ data }}</th>
          </tr>
        </thead>
        <tbody>
          <tr v-for="(row, rowIndex) in csvBody" v-bind:key="rowIndex">
            <td v-if="showCheckbox">
              <input type="checkbox" @change="onCheckBoxCheck(row)" />
            </td>
            <td v-for="(data, colIndex) in row" v-bind:key="colIndex">{{ data }}</td>
          </tr>
        </tbody>
      </table>
    </section>
  </div>
</template>

<script>
import CsvLoader from "./components/CsvLoader.vue";

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
    }
  }
};
</script>

<style>
#app {
  font-family: "Avenir", Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}

section {
  margin: 1em;
}

table {
  table-layout: auto;
}
</style>
