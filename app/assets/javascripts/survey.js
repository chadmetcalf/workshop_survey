var surveyJson = { title: "Workshop Registration",
  cookieName: "_workshop_survey_session",
  showProgressBar: "top",
  showQuestionNumbers: "false",
  pages: [
    { title: "How do we get a hold of you?",
      questions: [
      { type: "text", name: "name", isRequired: true, title: "Name"},
      { type: "text", name: "email", isRequired: true, validators: [{type:"email"}], title: "Email"}
    ]},
    {
      title: "We are looking to fill out the pilot with folks with all levels of experience.",
      questions: [
      { type: "matrix", name: "data", title: "What is your level of familiarity with the concept?",
        columns: [
        { value: 1, text: "Huh?" },
        { value: 2, text: " " },
        { value: 3, text: "Surface Level" },
        { value: 4, text: " " },
        { value: 5, text: "Evil Genius" }],
        rows: [{ value: "refactor", text: "Refactoring" },
        { value: "concept2", text: "Concept 2" },
        { value: "concept3", text: "Concept 3" },
        { value: "concept4", text: "Concept 4" }]}
    ]}
  ]
};

var mycustomSurveyStrings = {
  requiredError: "required",
  completingSurvey: "Thanks for registering! We'll have more information in the next couple of weeks.",
};
Survey.surveyLocalization.locales["en"] = mycustomSurveyStrings;
Survey.defaultBootstrapCss.navigationButton = "btn btn-primary";
Survey.defaultBootstrapCss.footer = "panel-footer text-center";
Survey.Survey.cssType = "bootstrap";

var survey = new Survey.Model(surveyJson);
survey.locale = "en";
survey.onComplete.add(sendDataToServer);
survey.showTitle = false;
survey.showPageTitles = true;

var app = new Vue({
  el: '#surveyContainer',
  data: {
    survey: survey
  },
  methods: {
  }
});


// var surveyData = { email: "something@example.com", data: { "better then others": "1"}};
// survey.data = surveyData;

function sendDataToServer(survey) {
  var surveyData = survey.data;
  if (JSON.stringify(surveyData) === JSON.stringify({})) {
    surveyData = {empty: true};
  }
  $.ajax({
    method: "POST",
    url: "/surveys",
    data: {'survey': surveyData}
  }).done(function(html) {
    return $("#results").append(html);
  })
}
