# URBAN JULIET — storefront starter

This is the first static storefront build for the URBAN JULIET project. It is designed for GitHub Pages and the agreed white/red premium visual direction. It includes a responsive homepage, animated product grid, category filters, search, sorting, cart drawer, newsletter UI, and a starter Supabase schema.

## Important before using it for real sales
- Catalogue items, prices, and fashion photographs are illustrative placeholders. They do not represent confirmed stock and must be replaced with client-approved product details and images.
- The supplied logo and exact brand font have not yet been verified from the Drive links. Add the approved logo artwork and licensed font when available.
- Cart and storefront interactions work in the browser, but checkout is intentionally disabled until secure backend work is completed.
- The included Edge Function is a safety placeholder, not a finished payment integration. Do not accept real orders yet.

## Preview locally
1. Extract the folder.
2. Open `index.html` in a browser, or use VS Code Live Server.
3. Product cards use internet-hosted image placeholders, so an internet connection is needed for them to display.

## Publish the static storefront on GitHub Pages
1. Create a new GitHub repository, for example `urban-juliet-store`.
2. Upload the contents of this folder (upload `index.html`, `assets/`, and `supabase/`; do not upload the parent folder as a nested folder).
3. In repository Settings → Pages, choose Deploy from a branch, select `main` and `/ (root)`, then Save.
4. Wait for GitHub Pages to publish and open the URL shown in Settings → Pages.

## Supabase setup (when ready)
1. Create a Supabase project and open SQL Editor.
2. Review and run `supabase/schema.sql`.
3. Configure the project URL and public anon key in `assets/js/app.js` only when you are ready to connect the frontend. Never place the service-role key or Paystack secret in frontend JavaScript.
4. Implement authenticated admin access and server-side order creation before exposing order data.

## Paystack production checklist
- Store the Paystack secret only as a Supabase Edge Function secret.
- Calculate prices on the server from active database products, never from browser-submitted prices.
- Persist a pending order before redirecting to Paystack.
- Verify the transaction server-side and validate the signed Paystack webhook before marking an order paid.
- Add stock reservation/decrement logic, delivery address validation, shipping fees, receipt emails, refund/cancellation handling, rate limits, and error logging.
- Test successful, failed, abandoned, duplicate, and replayed payment events using Paystack test mode before live mode.

## Before launch
- Replace all placeholder images with approved URBAN JULIET product photography that shows the subtle front chest mark and matching collar label where applicable.
- Confirm product names, sizes, colours, prices, stock, delivery fees, contact details, return policy, privacy policy, and terms with the client.
- Add secure admin management and customer checkout details. GitHub Pages alone cannot run PHP or private server code.
