{% if theme.cursor_effect.enabled %}
  {% if theme.cursor_effect.type == "fireworks" %}
    <script src="/js/src/clickDynamic/fireworks.js"></script>
  {% elseif theme.cursor_effect.type == "explosion" %}
    <canvas class="fireworks" style="position: fixed;left: 0;top: 0;z-index: 1; pointer-events: none;" ></canvas>
    <script src="//cdn.bootcss.com/animejs/2.2.0/anime.min.js"></script>
    <script src="/js/src/clickDynamic/explosion.min.js"></script>
  {% elseif theme.cursor_effect.type == "love" %}
    <script type="text/javascript" src="/js/src/clickDynamic/clicklove.js"></script>
  {% elseif theme.cursor_effect.type == "text" %}
    <script src="/js/src/clickDynamic/clicksocialvalue.js"></script>
  {% endif %}
{% endif %}