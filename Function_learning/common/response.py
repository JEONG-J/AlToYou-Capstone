from common.vars import model, prompt_word, prompt_food, prompt_dream
from datetime import datetime
import google.generativeai as palm
import logging
import os


def get_reply(user_id, sentence, character_name):
    if not sentence:
        return 'I can\'t understand. Can you say one more time?'
    if sentence[:7] == '<start>':
        start_conversation(user_id, character_name)
        return 'Success'
    else:
        write_log(user_id, sentence)
        res = get_palm_result(user_id, sentence, character_name)
        return res


def get_palm_result(user_id, sentence, character_name):
    context = get_context(user_id)
    palm.configure(api_key=os.getenv('palm_api_key'))
    prompt = get_prompt(character_name)
    prompt += context + '\n\nResponse: '
    completion = palm.generate_text(
        model=model,
        prompt=prompt,
        candidate_count=1,
        top_k=40,
        top_p=0.95,
        temperature=.1,
        max_output_tokens=1000,
        safety_settings=[{"category": "HARM_CATEGORY_DEROGATORY", "threshold": 4}, {"category": "HARM_CATEGORY_TOXICITY", "threshold": 4}, {"category": "HARM_CATEGORY_VIOLENCE", "threshold": 4}, {
            "category": "HARM_CATEGORY_SEXUAL", "threshold": 4}, {"category": "HARM_CATEGORY_MEDICAL", "threshold": 4}, {"category": "HARM_CATEGORY_DANGEROUS", "threshold": 4}],

    )
    res = completion.result
    # if character_name == 'Mongmong-e' and len(context) > 4:
    #     res = check_word_chain(res)
    if res == None:
        logging.error(
            'Following prompt could not generate any response\n'+prompt)
        for filter in completion.filters:
            print(filter['reason'])
        res = 'I can\'t understand. Please try again.'
    write_log(user_id, res)
    logging.debug('response: ' + res)
    return res


def get_context(user_id):
    with open(get_log_path(user_id), 'r') as f:
        dialogue = f.readlines()
    context = ''.join(dialogue)
    return context


def check_word_chain(res):

    return


def write_log(user_id, res):
    with open(get_log_path(user_id), 'a') as f:
        f.write(res + '\n')


def start_conversation(user_id, character_name):
    if user_id+'.log' in os.listdir('logs'):
        end_conversation(user_id)
    sentence = "Hi. I'm "+character_name + ". Nice to meet you!! What's your name?"
    #write_log(user_id, sentence)
    write_log(user_id, '')
    return


def end_conversation(user_id):
    os.rename(get_log_path(user_id), 'logs/' +
              user_id+'_'+str(datetime.now())+'.log')


def get_log_path(user_id):
    return 'logs/'+user_id+'.log'


def get_prompt(character_name):
    if character_name == 'Hindung-e':
        prompt = prompt_food
    elif character_name == 'Mongmong-e':
        prompt = prompt_word
    else:
        prompt = prompt_dream
    return prompt
