# Module VKApiMethods

A description of this package.

## The VK Api Methods module is designed to get the absolute URL for calling the API method

### **Using**

```
import VKApiMethods

let url = VKApiMethods.getAllFriends (token: "**Your API Access Token**", userId: "**ID of the user for whom the request is being made**").absoluteURL

```

***.absoluteURL*** _has an Optional type and will return either URL or nil_

