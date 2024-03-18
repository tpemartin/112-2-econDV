# Bar chart

## Image description

```python
from openai import OpenAI

client = OpenAI(api_key = "...")

response = client.chat.completions.create(
  model="gpt-4-vision-preview",
  messages=[
    {
      "role": "user",
      "content": [
        {"type": "text", "text": "What’s in this image?"},
        {
          "type": "image_url",
          "image_url": {
            "url": "https://www.economist.com/cdn-cgi/image/width=360,quality=80,format=auto/content-assets/images/20240323_EPC824.png"
            },
        },
      ],
    }
  ],
  max_tokens=300,
)

print(response.choices[0])
```

## Description Created Graph Example

AI>
```
Create an example dataframe with graphing codes that can generate a graph fitting the description: 'The image shows a bar chart titled "That rich taste," which presents data on worldwide market capitalization of selected categories of generative-AI businesses, in billion dollars ($bn). The chart compares the market capitalization on two dates: October 1st, 2022, and March 15th, 2024.\n\nThere are four categories listed:\n\n1. Cloud-computing companies\n2. Hardware companies\n3. Software applications\n4. Modelmakers\n\nFor each category, there are two bars indicating the market capitalization on the two respective dates, showing growth or changes between the two dates. The chart also includes a footnote which states, "Most recent funding round before the release of ChatGPT," indicating that the asterisk next to the 0.03 figure for Modelmakers refers to the most recent funding round before ChatGPT\'s release.\n\nOn the right-hand side of the chart, there are numbers indicating the number of companies surveyed in each category:\n\n- Cloud-computing companies: 3\n- Hardware companies: 27\n- Software applications: 19\n- Modelmakers: 11\n\nThe sources for the data are listed as Bloomberg, PitchBook, news reports, company reports, and The Economist.'
```