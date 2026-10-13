// Starter only. Before production, add strict request validation, rate limiting,
// trusted product-price lookup, order persistence, payment verification and webhook handling.
import { serve } from "https://deno.land/std@0.224.0/http/server.ts";
const corsHeaders = { "Access-Control-Allow-Origin": "*", "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type", "Access-Control-Allow-Methods": "POST, OPTIONS" };
serve(async (req) => {
  if (req.method === "OPTIONS") return new Response("ok", { headers: corsHeaders });
  if (req.method !== "POST") return new Response(JSON.stringify({ error: "Method not allowed" }), { status: 405, headers: { ...corsHeaders, "Content-Type": "application/json" } });
  const secret = Deno.env.get("PAYSTACK_SECRET_KEY");
  if (!secret) return new Response(JSON.stringify({ error: "Payment provider is not configured" }), { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } });
  // Do not use client-submitted prices in a real checkout. Resolve products and totals from Supabase first.
  return new Response(JSON.stringify({ error: "Checkout is intentionally disabled until server-side price validation, order creation, and payment verification are implemented." }), { status: 501, headers: { ...corsHeaders, "Content-Type": "application/json" } });
});
