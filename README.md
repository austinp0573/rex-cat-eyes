# rex-cat-eyes

- I found [tierhive](https://tierhive.com) and I didn't see a reason why I couldn't deploy a full Linux VPS that would provide a website with an https connection for less that $0.10/month. Turns out it works.

![Just under $0.10/month](./pics/very-cheap.webp)

## What's in here

- `cat-eyes/` - The directory that goes on the VPS's `/var/www/cat-eyes/`.
- `scripts/` - The script to do the inital server setup.
    - Amusingly, with 128MB of RAM:
        - Unless you clear the cache and provide swap space, you can't `apk update`.

## How to view it

**Go to [rex.tusko.org](https://rex.tusko.org)**

**Or**

**Scan the QR code**

![website-qr-code](./pics/qr-code.webp)

## SVG

- Honestly, probably the most annoying part was getting the svg just right. (even though it's not actually just right, if you look closely, there are little dots above the eyes)
    - Find suitable image (would have been nice to start with an .svg) import it into `inkscape`.
    - Use `Path` -> `Trace Bitmap`
    - Select all the elements you don't want and delete them.
    - Clean it up as much as possible.
    - Place a layer underneath that layer.
    - Find the color you like and edit the attributes (like the `animation` effect).
    - Save as a plain .svg.

## SSL

- In order to get a valid SSL certificate you could do a few things. I chose to use the HAproxy service that [tierhive](https://tierhive.com) provides.
- Need the webpage to be up and reachable.
- Then you validate your domain using the TXT record that [tierhive](https://tierhive.com) provides. 
- Then you configure the A record with your DNS provider.
- Once [tierhive](https://tierhive.com) sees that you have a valid A record, you can setup an SSL certificate.
- There will be an icon, just click it, and be patient.
    - It took like 10 minutes for mine to be valid and working. The GUI console said it was in there and working right, but it wasn't properly deployed to all the HAproxy endpoints on the backend. **just be patient**

## License

I'm releasing this under the GNU AGPLv3 license. You're completely free to use, modify, and share this code. The only catch is that if you make changes or use it to run a service over the web, you have to keep your version open source under the same license too.

&nbsp;

**466f724a616e6574**