import 'package:openai_dart/openai_dart.dart';
import 'package:admin/data/api/apiservice.dart';

class OpenAiTagGenerator {
  final String apiKey;

  OpenAiTagGenerator(this.apiKey);

  Future<List<String>> generateTags(
      String videoTitle, String videoDescription) async {
    final client = OpenAIClient(apiKey: apiKey);

    final response = await client.createChatCompletion(
      request: CreateChatCompletionRequest(
        model: ChatCompletionModel.modelId('gpt-4'),
        messages: [
          ChatCompletionMessage.system(
            content:
                "Given the video title '$videoTitle' and '$videoDescription', create the most relevant tag. it should be made in Korean. it have to be a noun.",
          ),
        ],
        temperature: 0.7,
      ),
    );

    final text = response.choices.first.message.content?.trim();
    if (text == null || text.isEmpty) {
      return [];
    }

    return text
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.length <= 15)
        .toList()
        .take(5)
        .toList();
  }
}

class OpenAiTagSuggester {
  final String apiKey;

  OpenAiTagSuggester(this.apiKey);

  Future<String> suggestTag(String videoTitle, String videoDescription) async {
    List<dynamic> existingTags = await ApiService().fetchTagList();

    String prompt =
        "Given the video title '$videoTitle' and '$videoDescription', suggest the most relevant tag from the following list: ${existingTags.map((e) => e['name']).join(', ')}.";

    String suggestedTagName = await getTagFromPrompt(prompt);

    return suggestedTagName;
  }

  Future<String> getTagFromPrompt(String prompt) async {
    final client = OpenAIClient(apiKey: apiKey);

    final response = await client.createChatCompletion(
      request: CreateChatCompletionRequest(
        model: ChatCompletionModel.modelId('gpt-4'),
        messages: [
          ChatCompletionMessage.system(
            content: prompt,
          ),
        ],
        temperature: 0.7,
      ),
    );
    final text = response.choices.first.message.content?.trim();
    print(text);
    return text ?? '';
  }
}
