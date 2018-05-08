def filter(request,keyword):
    Posts_match_title=Posts.objects.filter(title__contains=keyword)
    Posts_match_tag=Posts.objects.filter(tag__contains=keyword)
    all_categories =Category.objects.all()
    context={"Posts_match_title" :Posts_match_title ,"Posts_match_tag":Posts_match_tag,"all_categories":all_categories}
    return render (request,"pages/filter.html",context)

