public class DataParser {
	
	public static List<String> parse(String html){
		List<String>  res = new List<String> ();
			
		String badgeStart = '<div class=\'row\'>\n<div class=\'span2 user_stats\' data-target=\'#page2\' data-toggle=\'tab\' rel=\'badges\'>\n<a>\n<div class=\'stats_number\'>';
		String badgeEnd = '</div>';
		
		String scoreStart = '</div>\n<div class=\'span4 pull-right trailhead-points\'>\n<span class=\'trailhead-total-points\'>\n<i class=\'icon-star\'></i>\n<b>';
		String scoreEnd = '</b>';
		
		String badge = html.substringBetween(badgeStart, badgeEnd);
		String score = html.substringBetween(scoreStart, scoreEnd);

		res.add(badge);
		res.add(score);

		return res;
	}   
	
}