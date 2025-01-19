import { Controller } from "@hotwired/stimulus"
import EditorJS from "@editorjs/editorjs";

import Header from "@editorjs/header"
import List from "@editorjs/list"
import Paragraph from "@editorjs/paragraph"

// Connects to data-controller="editor"
export default class extends Controller {
  static targets = ["recipe_content"];
  connect() {

    const initialContent = this.getInitialContent();

    this.contentEditor = new EditorJS({
      placeholder: "Write preparation and other recipe related stuff here... Press / to type either text, heading or create a list.",
      holder: this.recipe_contentTarget,
      data: initialContent,
      tools: {
        header: {
          class: Header,
        },
        list: {
          class: List,
          config: {
            defaultStyle: "ordered",
            maxLevel: 1,
          },
        },
        paragraph: {
          class: Paragraph,
          config: {
            inlineToolbar: true,
          },
        },
      },
    });

    this.element.addEventListener("submit", this.saveEditorData.bind(this));
  }

  getInitialContent(){
    const hiddenContentField = document.getElementById("recipe_content_hidden");
    if (hiddenContentField && hiddenContentField.value){
      return JSON.parse(hiddenContentField.value);
    }
    return {};
  }

  async saveEditorData(event){
    event.preventDefault();

    const outputData = await this.contentEditor.save();
    const recipeForm = this.element;
    
    const hiddenInput = document.getElementById("recipe_content_hidden");

    hiddenInput.value = JSON.stringify(outputData);
    recipeForm.submit();
  }
}
