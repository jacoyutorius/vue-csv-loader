<template>
  <div id="csv-to-table">
    <form action>
      <div class="field is-horizontal">
        <div class="field-label is-normal">
          <label class="label">{{ headerRowCountLabelText }}</label>
        </div>
        <div class="field-body">
          <div class="field">
            <div class="control">
              <input id="headerRowCount" class="input" type="number" v-model="headerRowCount" />
            </div>
          </div>
        </div>
      </div>

      <div class="field is-horizontal">
        <div class="field-label is-normal">
          <label class="label">{{ uploadButtonLabelText }}</label>
        </div>
        <div class="field-body">
          <div class="file has-name is-fullwidth">
            <label class="file-label">
              <input class="file-input" type="file" @change="uploaded" />
              <span class="file-cta">
                <span class="file-icon">
                  <i class="fas fa-upload"></i>
                </span>
                <span class="file-label">{{ uploadButtonText }}</span>
              </span>
              <span class="file-name">{{ fileName }}</span>
            </label>
          </div>
        </div>
      </div>
    </form>
  </div>
</template>

<script>
import Encoding from "encoding-japanese";
import "bulma/css/bulma.css";

export default {
  name: "CsvLoader",
  props: {
    headerRowCountLabelText: {
      type: String,
      default: "Header Rows count",
      required: false
    },
    uploadButtonLabelText: {
      type: String,
      default: "CSV file",
      required: false
    },
    uploadButtonText: {
      type: String,
      default: "Choose file...",
      required: false
    }
  },
  data() {
    return {
      headerRowCount: 0,
      fileName: ""
    };
  },
  methods: {
    onCheckBoxCheck: function() {},
    uploaded: function(e) {
      const file = e.target && e.target.files && e.target.files[0];

      if (file) {
        this.fileName = file.name;

        this.loadCsv(file, sjisData => {
          const lineArray = sjisData.split("\r");
          const itemArray = [];
          let header = [];
          let body = [];

          for (let i = 0; i < lineArray.length; i++) {
            itemArray[i] = lineArray[i].split(",");
          }

          if (this.headerRowCount > 0) {
            header = itemArray.slice(0, this.headerRowCount);
            body = itemArray.slice(this.headerRowCount, itemArray.length - 1);
          } else {
            body = itemArray;
          }

          this.$emit("loadSuccess", {
            csvHeader: header,
            csvBody: body
          });
        });
      }
    },
    loadCsv: function(file, callBack) {
      const reader = new FileReader();
      reader.onerror = function() {
        alert(`${file}の読み込みに失敗しました。`);
      };
      reader.onload = () => {
        const str = String.fromCharCode.apply(
          "",
          new Uint8Array(reader.result)
        );

        const sjisData = Encoding.convert(str, {
          to: "UNICODE",
          from: "AUTO"
        });

        callBack(sjisData);
      };

      reader.readAsArrayBuffer(file);
    }
  }
};
</script>

<style scoped>
input#headerRowCount {
  width: 4em;
}
</style>