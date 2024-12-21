Map<String, int> countWords(String sentence){
  Map<String, int> outputMap = {};
  List<String> words = sentence.toLowerCase().split(RegExp("[' ' ? . , ; : ! \n \t]+"));
  for (String word in words){
    outputMap[word] = (outputMap[word] ?? 0) + 1; //Note: if outputMap[word] == null then outputMap[word] = 0
  }
  outputMap.remove(''); // Bỏ khoảng trắng
  return outputMap;
}
void main(){
  var res = countWords("Con bướm xinh, con bướm xinh, con bướm đa tình.");
  res.forEach((key, value) => print("$key: $value"));
}