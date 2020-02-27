import 'package:private_note/page/model/categoryGroup.dart';


class  CategoryGroupService{

    static CategoryGroup fromCode(String code){

        switch(code){

            case "prv":
            return PrivateGroup();
            case "hid":
            return HiddenGroup();
            default:
            return PublicGroup();
        }
    }
    // Return all groups
    static List<CategoryGroup> allCategoryGroup(){
        return [
            PublicGroup(),
            PrivateGroup(),
            HiddenGroup()
        ];
    }

    // get default selection
    static CategoryGroup getDefault(){
        return PublicGroup();
    }
}