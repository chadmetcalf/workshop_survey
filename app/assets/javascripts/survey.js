// showProgressBar: "top"
// cookieName: "myuniquesurveyid"
var surveyJson = { title: "Product Feedback Survey Example", pages: [
  {questions: [
    { type: "matrix", name: "data", title: "Please indicate if you agree or disagree with the following statements",
      columns: [{ value: 1, text: "Strongly Disagree" },
      { value: 2, text: "Disagree" },
      { value: 3, text: "Neutral" },
      { value: 4, text: "Agree" },
      { value: 5, text: "Strongly Agree" }],
      rows: [{ value: "affordable", text: "Product is affordable" },
      { value: "does what it claims", text: "Product does what it claims" },
      { value: "better then others", text: "Product is better than other products on the market" },
      { value: "easy to use", text: "Product is easy to use" }]},
    { type: "text", name: "email",
      title: "Thank you for taking our survey. Your survey is almost complete, please enter your email address in the box below if you wish to participate in our drawing, then press the 'Submit' button."}
  ]}
]};
var surveyData = { email: "something@example.com", data: { "better then others": "1"}};

Survey.defaultBootstrapCss.navigationButton = "btn btn-primary";
Survey.Survey.cssType = "bootstrap";
var survey = new Survey.Model(surveyJson);
survey.onComplete.add(sendDataToServer);

var app = new Vue({
  el: '#surveyContainer',
  data: {
    survey: survey
  },
  methods: {
  }
});
survey.data = surveyData;

function sendDataToServer(survey) {
  $.ajax({
      method: "POST",
      url: "/surveys",
      data: {'survey': survey.data}
  }).done(function(html) {
      return $("#results").append(html);
  })
}
