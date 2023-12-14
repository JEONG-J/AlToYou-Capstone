Fast api server for conversation using Palm2 api
For Python>=3.7

Setting

1. set env-var palm_api_key='Your api key'
2. run $sudo apt install python3.10 #if python not installed
3. run $sudo apt install python3-pip #pip version 22.0.2
4. run $pip install -r requirements.txt

Run 5. $python3 -m uvicorn main:app --host=0.0.0.0 --port=8080
