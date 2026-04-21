---
layout: page
title: Oglasi
permalink: /oglasi/
---

Ovde možete naći oglase vezane za kupoprodaju veslačke opreme.

{% assign active_ads = site.ads | where: "sold", false %}
{% assign sold_ads = site.ads | where: "sold", true %}

{% if site.ads.size == 0 %}
  *Trenutno nema aktivnih oglasa.*
{% else %}

## Aktivni oglasi

{% if active_ads.size == 0 %}
*Nema aktivnih oglasa.*
{% else %}
<div class="posts">
{% for ad in active_ads %}
  <div class="post">
    <a href="{{ ad.url | relative_url }}" class="post-link">
      <h3 class="post-title">{{ ad.title }}</h3>
    </a>
    <p class="post-summary">
      {% if ad.price %}<strong>{{ ad.price }}</strong> &mdash; {% endif %}
      {% if ad.location %}📍 {{ ad.location }} &mdash; {% endif %}
      {{ ad.summary }}
    </p>
    <a href="{{ ad.url | relative_url }}">Pogledaj oglas &rarr;</a>
  </div>
{% endfor %}
</div>
{% endif %}

{% if sold_ads.size > 0 %}
## Prodato

<div class="posts">
{% for ad in sold_ads %}
  <div class="post" style="opacity:0.55;">
    <h3 class="post-title" style="text-decoration:line-through;">{{ ad.title }}</h3>
    <p class="post-summary post-meta">PRODATO &mdash; {{ ad.summary }}</p>
  </div>
{% endfor %}
</div>
{% endif %}

{% endif %}
