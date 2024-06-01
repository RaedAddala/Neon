import requests


def get_key():
    url = "http://auth-service:4000/getKey"
    response = requests.get(url)

    if response.status_code != 200:
        raise requests.exceptions.ConnectionError(
            f"Failed to hit the endpoint, status code: {response.status_code}"
        )

    res = response.json()
    key = res["key"]
    f = open("/home/keys/public_key.pom", "w")
    f.write(key)
    f.close()

    print("Successfully hit the endpoint")


if __name__ == "__main__":
    get_key()
