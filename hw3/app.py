from flask \
    import Flask, request

import emoji

# Create app
app = Flask(__name__)


# Create func
@app.route('/', methods=['POST'])
def check_post():

    # Parse data as JSON, the result is not cached.
    REQ_JSON = request.get_json()

    # Input processing
    INP_EMO = str(REQ_JSON['animal'].lower())
    INP_SOUND = str(REQ_JSON['sound'].lower())
    INP_COUNT = int(REQ_JSON['count'])

    # Add author heart
    DISPLAY_AUTHOR_HEART = emoji.emojize(":yellow_heart:")

    # Adding delimeter to emo. Display emo with delimeter by syntax
    DEFAULT_DELIM = ":" + INP_EMO + ":"
    DISPLAY_EMO = emoji.emojize(DEFAULT_DELIM)


    # Display result with function variables
    return (((DISPLAY_EMO + " says " + INP_SOUND + "\n") * INP_COUNT) + "\n" + "Made with " + DISPLAY_AUTHOR_HEART + " by Vadim" + "\n")


@app.route('/', methods=['GET'])
def check_get():
  return ' Please send JSON with POST request!\n'

if __name__ == '__main__':
    app.run(port=80, host='0.0.0.0')